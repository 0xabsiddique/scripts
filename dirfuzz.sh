mkdir -p ~/Dirfuzz/dirsearch/$1
for url in $(cat ~/Dirfuzz/dirsearch/$1/subs.txt); do
  fqdn=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
  ~/Tools/dirsearch/dirsearch.py -b -t 50 -e php,asp,aspx,jsp,html,zip,jar,sql,bak,tar.gz -x 301,302,400,404,429,503,504 -r -w ~/wordlists/fuzz-php.txt -u $url --plain-text-report=~/Dirfuzz/dirsearch/$1/$fqdn.tmp

	if [ ! -s $~/Dirfuzz/dirsearch/$fqdn.tmp ]; then
		rm ~/Dirfuzz/dirsearch/$fqdn.tmp
	else
		cat ~/Dirfuzz/dirsearch/$fqdn.tmp | sort -k 1 -n > ~/Dirfuzz/dirsearch/$fqdn.txt
		rm ~/Dirfuzz/dirsearch/$fqdn.tmp
	fi
done
