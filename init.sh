# Ask for the administrator password upfront.
sudo -v


#########################
### Install XCode CLI ###
#########################

if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi

##############################
### Software Installations ###
##############################

echo '*** install homebrew ***'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

echo '*** install brew cask ***'
brew install caskroom/cask/brew-cask

echo '*** install node/npm ***'
brew install node

echo '*** install mongo ***'
brew install mongo

echo '*** install tree ***'
brew install tree

echo '*** install wget ***'
brew install wget

echo '*** install nodemon ***'
npm install -g nodemon

echo '*** install git ***'
brew install git

echo '*** install google chrome ***'
brew cask install --appdir="/Applications" google-chrome

echo '*** install google drive ***'
brew cask install --appdir="/Applications" google-drive

echo '*** install dropbox ***'
brew cask install --appdir="/Applications" dropbox

echo '*** install transmission ***'
brew cask install --appdir="/Applications" transmission

echo '*** iterm2 ***'
brew cask install --appdir="/Applications" iterm2

echo '*** install slack ***'
brew cask install --appdir="/Applications" slack

echo '*** install skype ***'
brew cask install --appdir="/Applications" skype

echo '*** install sublime text 3 ***'
brew cask install --appdir="/Applications" sublime-text3

echo '*** install steam ***'
brew cask install --appdir="/Applications" steam

echo '*** install league of legends ***'
brew cask install --appdir="/Applications" league-of-legends

echo '*** install open emu ***'
brew cask install --appdir="/Applications" openemu

echo '*** install alfred ***'
brew cask install --appdir="/Applications" alfred

echo '*** install flux ***'
brew cask install --appdir="/Applications" flux

echo '*** install hyperswitch ***'
brew cask install --appdir="/Applications" hyperswitch

echo '*** install keka ***'
brew cask install --appdir="/Applications" keka

echo '*** install scroll reverser ***'
brew cask install --appdir="/Applications" scroll-reverser

echo '*** install razer synapse ***'
brew cask install --appdir="/Applications" razer-synapse

echo '*** install spotify ***'
brew cask install --appdir="/Applications" spotify

echo '*** install spotify notifications ***'
brew cask install --appdir="/Applications" spotify-notifications

echo '*** install spotifree ***'
brew cask install --appdir="/Applications" spotifree

echo '*** install vlc ***'
brew cask install --appdir="/Applications" vlc

echo '*** install dropbox ***'
brew cask install --appdir="/Applications" dropbox

echo '*** cleaning up cask installs ***'
brew cask cleanup

echo '*** install cakebrew ***'
brew cask install cakebrew

echo '*** install ohmyzsh ***'
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"



#########################
### Computer Settings ###
#########################

# Set computer name
echo '*** set computer name ***'
sudo scutil --set ComputerName "avisamloff"
sudo scutil --set HostName "avisamloff"
sudo scutil --set LocalHostName "avisamloff"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "avisamloff"

# Set standby delay to 24 hours
echo '*** set standby delay ***'
sudo pmset -a standbydelay 86400

# Link Cask Apps to Alfred
echo '*** link cask apps to alfred ***'
brew cask alfred link

# Disable the warning before emptying the Trash
echo '*** disable warning before emptying the trash ***'
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
echo '*** show the ~/Library folder ***'
chflags nohidden ~/Library

# Remove Dropbox’s green checkmark icons in Finder
echo '*** remove the dropbox green checkmark from icons ***'
file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Speed up Mission Control animations
echo '*** speed up mission control animations ***'
defaults write com.apple.dock expose-animation-duration -float 0.2

# Prevent Time Machine from prompting to use new hard drives as backup volume
echo '*** stop time machine from asking about new drives ***'
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable Dashboard
echo '*** disable dashboard ***'
defaults write com.apple.dashboard mcx-disabled -bool true

# Make Dock icons of hidden applications translucent
echo '*** make hidden app icons translucent ***'
defaults write com.apple.dock showhidden -bool true

# Disable the Launchpad gesture (pinch with thumb and three fingers)
echo '*** disable launchpad gesture ***'
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
echo '*** add the keyboard shortcut ⌘ + Enter to send an email ***'
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

# Disable prompt when quitting iterm2
echo '*** Disable prompt when quitting iterm2 ***'
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Don’t automatically rearrange Spaces based on most recent use
echo '*** stop automatically rearranging spaces based on time ***'
defaults write com.apple.dock mru-spaces -bool false

# Menu bar: hide the Time Machine and User icons
echo '*** hide the time machine and user icons from the menu bar ***'
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
  defaults write "${domain}" dontAutoLoad -array \
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
    "/System/Library/CoreServices/Menu Extras/User.menu"
done

# Set sidebar icon size to medium
echo '*** set sidebar icons in finder to medium size ***'
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# expand save prompt
echo '*** expand save prompt ***'
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# quit printer app when there are no pending jobs
echo '*** quit printer app when there are no pending jobs ***'
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# save to disk instead of iCloud by default
echo '*** set default save location to disk instead of icloud ***'
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# check for updates daily
echo '*** check for Apple updates daily ***'
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# disable smart quotes, auto-correct spelling, and smart dashes
echo '*** disable smart quotes, auto-correct spelling, and smart dashes ***'
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# prevent Photos from opening when inserting external media
echo '*** prevent photos from opening when instering drives ***'
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# sets clock to 24-hour mode
echo '*** set clock to 24-hour mode ***'
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# disable hibernate
echo '*** disable hibernate ***'
sudo pmset -a hibernatemode 0

# disable sudden motion sensor
echo '*** disable the sudden motion sensor ***'
sudo pmset -a sms 0

# increase Bluetooth sound quality
echo '*** increase bluetooth sound quality ***'
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# disable press-and-hold for special keys
echo '*** disable special key press-and-hold ***'
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# increase key repeat rate
echo '*** increase key repeat rate ***'
defaults write NSGlobalDomain KeyRepeat -int 0

# disable auto-brightness on keyboard and screen
echo '*** disable auto-brightness ***'
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

# create folder for screenshots in documents
echo '*** create folder for screenshots in documents ***'
defaults write com.apple.screencapture location -string "${HOME}/Documents/screenshots"

# enable hidpi mode
echo '*** enable hidpi ***'
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# enable font rendering on non-apple displays
echo '*** enable font rendering on non-apple displays ***'
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# show full path in finder
echo '*** show full path in finder ***'
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# disable warning when changing file extension
echo '*** disable warning when changing file extension ***'
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# disable .DS_Store on network drives
echo '*** prevent creation of .DS_Store on network drives ***'
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# enable snap to grid for desktop and icon view
echo '*** enable snap to grid ***'
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# set column view as default
echo '*** set column view as default in finder ***'
defaults write com.apple.finder FXPreferredViewStyle Clmv

# set dock icons to 48px
echo '*** set dock icons to 48px ***'
defaults write com.apple.dock tilesize -int 48

# disable focus ring
echo '*** disable focus ring ***'
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# reformat copying email addresses
echo '*** reformat copying email addresses in mail.app ***'
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

#disable gatekeeper
echo '*** disable gatekeeper ***'
sudo spctl --master-disable

# disable npm progress bar (doubles install speed)
echo '*** disable npm progress bar ***'
npm set progress=false

# set tap-to-click
echo '*** enable tap-to-click ***'
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1

# change crash reporter to notification
echo '*** change crash reporter to notification ***'
defaults write com.apple.CrashReporter UseUNC 1

# download sublime package manager
echo '*** download sublime package manager ***'
curl https://sublime.wbond.net/Package%20Control.sublime-package > /Users/avisamloff/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package

# download .gitconfig
echo '*** create global .gitconfig ***'
curl -O https://raw.githubusercontent.com/nicolashery/mac-dev-setup/master/.gitconfig > ~/.gitconfig

# create global .gitignore
echo '*** create global .gitignore ***'
echo '
# Folder view configuration files
.DS_Store
Desktop.ini

# Thumbnail cache files
._*
Thumbs.db

# Files that might appear on external disks
.Spotlight-V100
.Trashes

# Compiled Python files
*.pyc

# Compiled C++ files
*.out

# Application specific files
venv
node_modules
.sass-cache
' > ~/.gitignore

# set git user info and credentials
echo '*** set git user info and credentials ***'
git config --global user.name "Avi Samloff"
git config --global user.email "avi.samloff@gmail.com"
git config --global credential.helper osxkeychain


# update PATH
echo '*** update path ***'
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

# set sublime packages
echo '*** set sublime packages ***'
echo '
{
  "bootstrapped": true,
  "in_process_packages":
  [
  ],
  "installed_packages":
  [
    "BracketHighlighter",
    "Color Highlighter",
    "GitGutter",
    "HTML-CSS-JS Prettify",
    "Package Control",
    "Predawn",
    "SideBarEnhancements",
    "SublimeLinter",
    "SublimeLinter-jshint",
    "Theme - Spacegray"
  ]
}
' > /Users/avisamloff/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings

# Disable local Time Machine snapshots
echo '*** disable local time machine snapshots ***'
sudo tmutil disablelocal


#############################
### Transmission Settings ###
#############################

# setup folder for incomplete torrents
echo '*** set up folder for incomplete torrents ***'
mkdir -p ~/Downloads/Incomplete
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"

# hide donate message
echo '*** hide transmission donate message ***'
defaults write org.m0k.transmission WarningDonate -bool false

# hide legal warning
echo '*** hide transmission legal warning ***'
defaults write org.m0k.transmission WarningLegal -bool false

# auto resize window
echo '*** auto resize transmission window ***'
defaults write org.m0k.transmission AutoSize -bool true

# setting block-list
echo '*** set up transmission block-list ***'
defaults write org.m0k.transmission EncryptionRequire -bool true
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"



#############################
### Sublime Text Settings ###
#############################

# set sublime as default text editor in git
echo '*** set sublime text as default text editor in git ***'
git config --global core.editor "subl -n -w"

#set sublime as default text editor os-wide
echo '*** set sublime text as default text editor os-wide ***'
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add \
'{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.sublimetext.3;}'
