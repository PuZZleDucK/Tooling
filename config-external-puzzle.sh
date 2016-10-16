# Setup tools outside the package manager

download_dir="/tmp/puzzle-cache"

echo "Caching to $download_dir and wiping cache."
read -p "... this may take some time... enter to continue or <ctrl>-c to abort.\n"

rm -Rf $download_dir
mkdir $download_dir

# Download external tools
for line in `cat external-list.txt | tr " " "_"` ; do
    echo -e "Line: ${line}"
    if [[ "${line:0:1}" != "#" ]] ; then
	wget -P "$download_dir" "$line"
    else
	echo -e "\n  ### Downloading $line ###"
    fi
done


for line in `ls $download_dir` ; do
    echo -e "\n  ### Running donload of $line ###"
    $download_dir/$line
done

# rm -Rf $download_dir
echo "Cleared out $download_dir."
