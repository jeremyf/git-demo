#!/usr/bin/env ruby

# Pathname provides useful methods for working the filesystem.
require 'pathname'  

this_file = Pathname.new(__FILE__)

require this_file.dirname.join('command_runner.rb')

CommandRunner.context do

  run(
    "git init", 
    "Change directory into '#{target_directory}' and initialize the git repository"
  )
  
  run(
    "cp #{this_file.expand_path} ./", 
    "Copy the demo-builder file into '#{target_directory}'."
  )
  
  run(
    "cp #{this_file.expand_path.dirname.join('command_runner.rb')} ./",
    "Copy the rb into '#{target_directory}'."
  )
  
  run(
    "cp #{this_file.expand_path.dirname.join('file.txt')} ./",
    "Copy the rb into '#{target_directory}'."
  )
  
  run(
    "git add .", 
    "Add #{this_file.basename} to the git repository. This is now staged. Think of this as completing editorial review."
  )
  
  run(
    "git commit -m 'Added #{this_file.basename}'", 
    "Commit the change to the repository.  Think of it as publishing the changes."
  )
  
  run(
    "git log",
    "Show the entire log history."
  )
  
  run(
    "cp #{this_file.expand_path.dirname.join('command_runner_test.rb')} ./",
    "Copy the command_runner_test into '#{target_directory}'."
  )
  
  run(
    "git status",
    "Note the command_runner_test.rb is not added to the repository."
  )
  
  run(
    "git branch",
    "List the branches of the repository."
  )
  
  run(
    "git checkout -b adding-test",
    "I am creating a new branch for adding the command_runner_test.rb"
  )
  
  run(
    "git branch",
    "List the branches of the repository.  The one with the asterisk is the current branch."
  )
  
  run(
    "git add . && git commit -m 'Adding command_runner_test.rb'",
    "Add the all of the files and commit the changes."
  )
  
  run(
    "ls -la",
    "List all of the files in the demo. (note the .git directory, magic happens in there)"
  )
  
  run(
    "git checkout master && ls -la",
    "Switch to the master branch then list all of the files. Notice how the command_runner_test.rb file is missing?"
  )
  
  run(
    "git diff adding-test",
    "Determine the diff between two branches."
  )
  
  run(
    "git merge adding-test",
    "Merge the two branches."
  )
  
  run(
    "git diff adding-test",
    "Notice there is no difference between the master and adding-test branch."
  )
  
  run(
    "ls -la",
    "And notice how command_runner_test.rb is now in the master branch."
  )
  
  run(
    "git log",
    "And lets see what all has been recorded in the history."
  )
  
  run(
    "git checkout HEAD^",
    "Lets checkout the code-base prior to the last commit."
  )
  
  run(
    "ls -la",
    "Notice command_runner_test.rb is not here."
  )
  
  run(
    "git branch",
    "Notice the current branch is not master.  It is *(no branch)"
  )
  
  run(
    "git checkout master",
    "Let's checkout the master branch again"
  )
  
  run(
    "ls -la",
    "The command_runner_test.rb file is back."
  )
  
  run(
    "git status",
    "And everything is up to date."
  )
  
  run(
    "ruby command_runner_test.rb",
    "Run my auto tests."
  )
  
  run(
    "echo '#{CommandRunner::VALUE*2}' > ./file.txt",
    "I'm going to alter the file.txt"
  )
  
  run(
    "git add . && git commit -m 'Update file.txt value without running tests, shame on me'",
    "Commit the changes to file.txt.  I'm going to forget about this for a moment."
  )
  
  run(
    "git annotate ./file.txt", "We can see who did what and when. Helpful to know when and who made the change.  Definitely a case for good messages to convey the purpose of the commit."
  )
  
  run(
    "cp #{this_file.expand_path.dirname.join('pre-commit')} ./.git/hooks/pre-commit",
    "I'm going to add a git hook.  There are plenty of hooks available:  
    You just have to write what you want them to do.  Parse all changed files before committing?  Format all commit messages to be 80 lines?"
  )
  
  run(
    "git status",
    "Those hooks aren't part of the repository"
  )
  
  run(
    "touch README && git add . && git commit -m 'Added README'",
    "Add README to the repository, and commit the change."
  )
  run(
    "ruby command_runner_test.rb",
    "Run my auto tests... Notice that they failed?"
  )
  
  run(
    "git checkout master &&
      git bisect start && 
      git bisect bad HEAD && 
      git bisect good HEAD^^ &&
      git bisect run ruby ./command_runner_test.rb
    ",
    "git bisect allows you to run a command on the repository.  You indicate which commit is bad, which is good, and then indicate which command will tell you the success."
  )
  
  run(
    "git checkout master &&
      git bisect start && 
      git bisect bad HEAD && 
      git bisect good HEAD^^ &&
      git bisect run ruby ./command_runner_test.rb  | grep -e '.*is the first bad commit'
    ",
    "Let's see the bisect results again, but highlight the line that mentions the first bad commit."
  )
  
  run(
    "git branch",
    "The bisect runs in its own branch call *(no branch)"
  )
  
  run(
    "git log",
    "Notice the commit SHA1 that is highlighted from bisect"
  )
  
  run(
    "git diff HEAD^",
    "(Cheating a bit) Now that I know which commit was broken, I run a diff to see what changed."
  )
  
  run(
    "git checkout master && echo '#{CommandRunner::VALUE}' > ./file.txt",
    "Correct the mistake made to file.txt"
  )
  
  run(
    "git add . && git commit -m 'Fixed ./file.txt'",
    "Commit the change"
  )
  
  run(
     "ruby command_runner_test.rb",
     "The tests run."
  )

  run(
     "open .",
     "Lets open the underlying directory (OS X only)"
  )
end