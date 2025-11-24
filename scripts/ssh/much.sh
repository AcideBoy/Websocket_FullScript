gum format --theme dracula --type markdown <<EOF
This is how much connected to your Server
EOF
echo $(ss -tnp | grep ':7080' | grep -c 'nginx')
gum confirm "Return to menu?" && asx
