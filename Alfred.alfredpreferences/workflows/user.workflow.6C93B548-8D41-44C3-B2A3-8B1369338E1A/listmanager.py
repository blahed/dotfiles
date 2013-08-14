# -*- coding: utf-8 -*-
import os
from uuid import uuid4

import config
import config_keys as ck
import helpers
import alfred



def generate_feedback(path, todo_file, active=False):
    return alfred.Item(
        attributes={
            'uid': uuid4(),
            'arg': os.path.join(path, todo_file),
            'valid': 'yes' #if not active else 'no'
        },
        title=friendly_file(todo_file),
        subtitle="Active" if active else "",
        icon="todo_edit.png" if active else "icon.png"
    )

def friendly_file(todo_file):
    return todo_file.replace(".yaml",'').replace(".taskpaper",'')

def default_format():
    format = config.get(ck.KEY_FORMAT_DEFAULT)
    if format == 'todo.keyvalue.none':
        return ".yaml"
    return format


def generate_add_feedback(path, todo_file):
    todo_file = helpers.cleanup_filename(todo_file)
    return alfred.Item(
        attributes={
            'uid': uuid4(),
            'arg': os.path.join(path, todo_file+default_format()),
            'valid': 'yes' if todo_file != 'config' else 'no'
        },
        title="New list '" + todo_file + "'",
        subtitle="",
        icon="todo_add.png"
    )


def generate_view(query):
    lists, active = get_todo_lists()
    (path, db) = os.path.split(config.get(ck.KEY_TODO))
    lists = [f for f in lists if len(query) == 0 or friendly_file(f).lower().find(query.lower()) >= 0]
    feedback_items = map(lambda x: generate_feedback(path, x, x == active), lists)
    if len(feedback_items) == 0:
        feedback_items.append(generate_add_feedback(path, query))
    alfred.write(alfred.xml(feedback_items))


def get_todo_lists():
    (path, db) = os.path.split(config.get(ck.KEY_TODO))
    lists = [f for f in os.listdir(path) if f.endswith('.yaml') or f.endswith('.taskpaper')]
    # remove config.yaml
    if 'config.yaml' in lists:
        lists.remove('config.yaml')
    if len(lists) == 0:
        lists.append('todo' + default_format())
        config.put(ck.KEY_TODO, os.path.join(path, 'todo'+default_format()))
    return sorted(lists), db


def action_list(todo_file):
    if todo_file==config.get(ck.KEY_TODO):
        return
    if not os.path.exists(todo_file):
        open(todo_file, 'w').close()
    config.put(ck.KEY_TODO, todo_file)
    #print "List '" + todo_file.replace(".yaml", "") + "' is now active"


def delete_list(todo_file):
    (path, todo_filename) = os.path.split(todo_file)
    if os.path.exists(todo_file):
        os.remove(todo_file)
        print "Removed list '" + friendly_file(todo_filename) + "'"
    # if we removed the active one, switch to a new active list
    lists, active = get_todo_lists()
    if todo_file==config.get(ck.KEY_TODO):
        config.put(ck.KEY_TODO, os.path.join(path, lists[0]))


def active_list():
    (path, db) = os.path.split(config.get(ck.KEY_TODO))
    return db

def main():
    (option, query) = alfred.args2()
    option_actions = {
        # Lists
        '-view': lambda q: generate_view(q),
        '-action': lambda q: action_list(q),
        '-delete': lambda q: delete_list(q)
    }
    option_actions[option](query)
    config.commit()

if __name__ == '__main__':
    main()
