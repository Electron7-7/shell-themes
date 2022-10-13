#!/bin/bash
_solomente() {
	if [[ $choice == 1 || $choice == 3 ]]; then
		echo 'export CUSTOM_PROMPTS="'$PROMPTS_PATH'/.cool_prompts"' >> $HOME/.bashrc
		echo '. $CUSTOM_PROMPTS/shellme custom-prompt-1' >> $HOME/.bashrc
		echo 'alias shellme="$CUSTOM_PROMPTS/shellme"' >> $HOME/.bashrc
		#echo "bash!"; sleep 1
	fi

	if [[ $choice == 2 || $choice == 3 ]]; then
		echo 'export CUSTOM_PROMPTS="'$PROMPTS_PATH'/.cool_prompts"' >> $HOME/.zshrc
		echo '. $CUSTOM_PROMPTS/shellme custom-prompt-2' >> $HOME/.zshrc
		echo 'alias shellme="$CUSTOM_PROMPTS/shellme"' >> $HOME/.zshrc
		#echo "zsh!"; sleep 1
	fi
}

_install() {
	mkdir $PROMPTS_PATH/.cool_prompts
	export CUSTOM_PROMPTS="$PROMPTS_PATH/.cool_prompts"
	echo -e "Do you want to install custom prompts for both bash and zsh, or just one?"
	echo -e "(1) BASH only\n(2) ZSH only\n(3) Both shells\n"
	while true; do
		read -r -p "[ANSWER]: " choice
		case $choice in
			[1]* ) echo "Configuring for a BASH only installation..."; break;;
			[2]* ) echo "Configuring for a ZSH only installation..."; break;;
			[3]* ) echo "Configuring for a BASH and ZSH installation..."; break;;
			* ) echo "Please answer 1, 2, or 3";;
		esac
	done

	_solomente

	cp -r ./bin/* $CUSTOM_PROMPTS/

	clear
	echo "Installation finished! Type 'shellme -h' for into on the script! Happy scripting!"; sleep 2
	echo -n "Exiting"
	echo -n "."; sleep 1
	echo -n "."; sleep 1
	echo -n "."; sleep 1
	echo -e "\nnow"; sleep 0.2
	clear

	exit 0
}

_driven() {
	echo "Now you, you take your destiny by the hand and drag it along!"
	echo "I like that, and I like you"
	echo "Now, take your pick"
	while true; do
		export PROMPTS_PATH
		read -r -p "[PATH]: " PROMPTS_PATH
		if [[ -z $PROMPTS_PATH ]]; then
			echo "[NO PATH GIVEN!!]"
			echo "_TRY AGAIN_"
		else
			echo "Your path has been chosen. I do hope you chose wisely..."
			echo "continuing installation..."
			_install
		fi
	done
}

_complacent() {
	PROMPTS_PATH=$HOME
	echo "Sounds good to me, pal! Let's get rolling!"
	_install
}

clear

cat << EOF
Yo, just a heads up: this stuff needs to go somewhere and by somewhere I mean another hidden directory.
However, I know how annoying it is to have to add another config folder to your home directory, so as an olive
branch, you have the choice to bite the bullet and let this hidden file join the horde, or if by the strength of God Himself you wish to organize your home directory, you may.

So, do you want to choose your own... path?

EOF

while true; do
	read -r -p "Set custom hidden folder path? [Y/N]: " choice
	case $choice in
		[Yy]* ) clear; _driven; break;;
		[Nn]* ) clear; _complacent; break;;
		* ) clear; echo -e "Please answer Y or N\n"; sleep 1;;
	esac
done
