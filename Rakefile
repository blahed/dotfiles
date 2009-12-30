DOTFILES = %w(zshrc gitconfig emacs)
 
task :default => [:usage]
task :usage do
  description = <<-DOC
    Usage: rake install
    Install the dotfiles in the current user's home directory.
    Files that existed prior to this dotfiles will be moved
    to the '.pre_dotfiles' directory with a timestamp.
DOC
  puts description
end

task :install do
  include InstallHelper
  create_backup_dir unless File.exist? backup_dir
  DOTFILES.each do |file|
    filename = split_all(file).last
    create_backup filename
    create_link filename
  end
end

module InstallHelper
  def backup_dir
    @@backup_dir ||= File.join(ENV['HOME'], ".pre_dotfiles")
  end
  
  def create_backup_dir
    sh %{mkdir "#{backup_dir}"} do |ok, res|
      puts "Could not create #{backup_dir} (status = #{res.exitstatus})" unless ok
    end
  end
 
  def create_backup(file)
    dotfile = File.join(ENV['HOME'], ".#{file}")
    if File.exist? dotfile
      backup_file = "#{Time.now.strftime("%Y%m%d%k%M%S")}-#{file}"
      sh %{mv "#{dotfile}" "#{File.join(backup_dir, backup_file)}"} do |ok, res|
        puts "Could not backup .#{file} (status = #{res.exitstatus})" unless ok
      end
    end
  end
 
  def create_link(file)
    dotfile = File.join(Rake.original_dir, file)
    target = File.join(ENV['HOME'], ".#{file}")
    safe_ln(dotfile, target) unless File.exist? target
  end
end