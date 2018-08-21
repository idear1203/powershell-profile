Add-PathVariable "${env:ProgramFiles}\rethinkdb"

# To use git supplied by SourceTree instead of the 'git for Windows' version
# Add-PathVariable "${env:LOCALAPPDATA}\Atlassian\SourceTree\git_local\bin"

# Produce UTF-8 by default
# https://news.ycombinator.com/item?id=12991690
$PSDefaultParameterValues["Out-File:Encoding"]="utf8"

# Tab completion for git (also modified prompt, which I dislike, so disabled)
# Install-Module posh-git
# Load posh-git example profile
# . 'C:\Users\mike\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1'

function gg {
	# Replace file:linenumber:content with file:linenumber:content
	# so you can just click the file:linenumber and go straight there.
	& git grep -n -i @args | foreach-object { $_ -replace '(\d+):','$1 ' }  
}

function get-git-ignored {
	git ls-files . --ignored --exclude-standard --others
}

function get-git-untracked {
	git ls-files . --exclude-standard --others
}

# For git rebasing
# --wait required, see https://github.com/Microsoft/vscode/issues/23219 
$env:EDITOR = 'code --wait'

# Kinda like $EDITOR in nix
# You may prefer eg 'subl' or 'code' or whatever else
# --disable-gpu needed for https://github.com/Microsoft/vscode/issues/13612
function edit {
	& "code" --disable-gpu -g @args
}

# I used to run Sublime so occasionally my fingers type it
function subl {
	# 	& "$env:ProgramFiles\Sublime Text 3\subl.exe" @args
	write-output "Type 'edit' instead"
}