DOTFILES = %w(zshrc gitconfig emacs)
BIN_FOLDERS = %w(applescripts)
 
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
  create_bin_dir unless File.exist? bin_dir
  
  DOTFILES.each do |file|
    create_backup file
    create_link file
  end
  
  BIN_FOLDERS.each do |folder|
    Dir[File.join(Rake.original_dir, folder, '*')].each do |file|
      target = File.join(ENV['HOME'], 'bin', split_all(file).last)
      safe_ln(file, target) unless File.exist? target
    end
  end
end

module InstallHelper
  def backup_dir
    @@backup_dir ||= File.join(ENV['HOME'], '.pre_dotfiles')
  end
  
  def bin_dir
    @@bin_dir ||= File.join(ENV['HOME'], 'bin')
  end
  
  def create_backup_dir
    sh %{mkdir "#{backup_dir}"}
  end
  
  def create_bin_dir
    sh %{mkdir "#{bin_dir}"}
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