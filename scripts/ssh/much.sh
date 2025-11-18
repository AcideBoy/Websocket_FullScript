gum format --theme dracula --type markdown <<EOF
This is how much connected to your Server
EOF
echo $(( $(ss -tuna | grep ':80' | wc -l) - 1 ))
gum confirm "Return to menu?" && asx