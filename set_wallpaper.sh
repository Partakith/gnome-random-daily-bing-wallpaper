#!/bin/bash

# Function to detect GDM theme mode
detect_gdm_theme_mode() {
    gdm_status=$(gsettings get org.gnome.desktop.interface gdm-theme)
    if [ "$gdm_status" == "'gdm3.css'" ]; then
        echo "dark"
    else
        echo "light"
    fi
}

# Function to fetch random image URL from Bing gallery
fetch_random_bing_gallery_image() {
    # List of Bing galleries you can choose from
   # List of Bing galleries
local galleries=(
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=ja-JP",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=en-US",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=zh-CN",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=fr-FR",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=de-DE",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=es-ES",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=it-IT",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=pt-BR",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=ru-RU",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=ar-SA",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=hi-IN",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=ko-KR",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=nl-NL",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=pl-PL",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=tr-TR",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=th-TH",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=sv-SE",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=fi-FI",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=da-DK",
    "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=nb-NO"
    # Add more galleries here if needed
)
    
    # Select a random gallery URL
    local random_index=$(( RANDOM % ${#galleries[@]} ))
    local gallery_url="${galleries[$random_index]}"
    
    # Fetch JSON data for the selected gallery
    local gallery_data=$(wget -qO- "$gallery_url")
    
    # Parse the image URL from the JSON response
    local url=$(jq -r '.images[] | .url' <<< "$gallery_data" | shuf -n 1)
    url="https://www.bing.com${url}"
    
    echo "$url"
}

# Clear cache
PICS="/home/$USER/Pictures"
RAND=$RANDOM

rm -f "${PICS}"/*.jpg
rm -f "${PICS}/bing-wallpaper.json"

# Fetch random image URL from Bing gallery
url=$(fetch_random_bing_gallery_image)

# Download the image
wget -q "$url" -O "${PICS}/wall${RAND}.jpg"

# Set the desktop background based on GDM theme mode
gdm_mode=$(detect_gdm_theme_mode)
if [ "$gdm_mode" == "light" ]; then
    URI="file://${PICS}/wall${RAND}.jpg"
else
    URI="file://${PICS}/wall${RAND}.jpg"
fi

echo "${URI}"
gsettings set org.gnome.desktop.background picture-options 'centered'
gsettings set org.gnome.desktop.background picture-uri "${URI}"
gsettings set org.gnome.desktop.background picture-uri-dark "${URI}"