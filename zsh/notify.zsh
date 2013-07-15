notify() {
	RBENV_VERSION=`rbenv global`
	local msg="${*}"
	terminal-notifier -name 'Terminal' -message $msg -group TerminalNotifier > NULL
	terminal-notifier -remove TerminalNotifier > NULL
}
