# -*- coding: utf-8 -*-
import config
import config_keys as ck
from YamlStore import YamlStore
from TaskpaperStore import TaskpaperStore


class Store:
    def __init__(self):
        todo_db = config.get(ck.KEY_TODO)
        self.instance = self.get_store(todo_db)

    def get_store(self, todo_db):
        if todo_db.endswith('.yaml'):
            return YamlStore(todo_db)
        if todo_db.endswith('.taskpaper'):
            return TaskpaperStore(todo_db)
        return None




datastore = Store()

