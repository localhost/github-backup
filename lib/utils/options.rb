require 'optparse'

module GitHubBackup
    class Options
        class << self
            attr_accessor :options
            def parse
                self.options ||= {}

                optparse = OptionParser.new do|opts|
                    
                    # TODO: update usage
                    opts.banner = "Usage: github-backup -u [username] -o [dir]
e.g
github-backup -u hbt -o /tmp \n\n"
                    #        backup.rb *githubUsername* *githubPassword* [--github-user=XXX] [--repo=XXX] [--all-branches] [--all-forks] [--issues] [--wiki]
                    #        backup.rb [--github-user=XXX] [--repo=XXX] [--all-branches] [--all-forks] [--issues] [--wiki]
                    #        backup.rb --username=XXX --password=XXX [--github-user=XXX] --repo=XXX --all-branches --all-forks --issues --wiki

                    opts.on( '-e', '--email EMAIL', 'Optional: GitHub email/username. Required for private repos') do |f|
                        self.options[:email] = f
                    end

                    opts.on( '-p', '--password PASSWORD', 'Optional: GitHub password. Required for private repos') do |f|
                        self.options[:passwd] = f
                    end

                    opts.on( '-u', '--username USERNAME', '*Required: GitHub username') do |f|
                        self.options[:username] = f
                    end

                    opts.on( '-o', '--output-dir DIR', '*Required: Backup directory') do |f|
                        self.options[:bakdir] = File.expand_path(f)
                    end

                    opts.on( '-r', '--repository-name NAME', 'Optional: limit to this repository name' ) do |f|
                        self.options[:reponame] = f
                    end

                    opts.on( '-f', '--forks', 'Optional: fetch all forks' ) do
                        self.options[:forks] = true
                    end

                    opts.on( '-b', '--init-branches', 'Optional: init all branches' ) do
                        self.options[:init_branches] = true
                    end

                    opts.on( '-i', '--dump-issues', 'Optional: dump all issues' ) do
                        self.options[:issues] = true
                    end

                    opts.on( nil, '--dump-issues-filename FILENAME', 'Optional: dump issues filename' ) do |f|
                        self.options[:issues_filename] = f
                    end

                    opts.on( '-w', '--wiki', 'Optional: dump wiki' ) do
                        self.options[:wiki] = true
                    end

                    opts.on( '-v', '--version', 'Displays current version ' ) do
                        #TODO
                    end

                    opts.on( '-h', '--help', 'Displays this screen' ) do
                        p opts
                        exit
                    end
                end

                optparse.parse!

                if !is_valid?
                    puts optparse
                    exit
                end
            end

            # check required options
            def is_valid?
                return false unless self.options[:bakdir] && File.exists?(self.options[:bakdir])
                return false unless self.options[:username]
                true
            end

        end
    end
end