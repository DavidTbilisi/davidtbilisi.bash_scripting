# LOCATE
[Docs](https://manpages.debian.org/bookworm/plocate/locate.1.en.html)
[Examples](https://tldr.inbrowser.app/pages/linux/locate)
```bash
locate filename
```

```bash
locate -i filename
```

```bash
locate '*.txt'
```

```bash
locate -n 10 filename
```

```bash
locate -r 'pattern.*\.txt'
```


```bash
sudo updatedb
```





# FIND 
[Docs](https://manpages.debian.org/bookworm/findutils/find.1.en.html)
[Examples](https://tldr.inbrowser.app/pages/common/find)
```bash
find /path/to/search -iname "filename"
```

```bash
find /path/to/search -name "*.txt"
```


```bash
find /path/to/search -name "*.log" -exec rm {} \;
```


```bash
find /path/to/search -type d
```

```bash
find /path/to/search -type f
```

```bash
find /path/to/search -size +10M
```

```bash
find /path/to/search -mtime -7
```


# GREP
[Docs](https://manpages.debian.org/bookworm/grep/grep.1.en.html)
[Examples](https://tldr.inbrowser.app/pages/common/grep)
## პარამეტრები
`-i` რიგისტრს არ მიაქციო ყურადღება <br>
`-r` მოძებნე შიდა ფაილებში და საქაღალდეებშიც <br>
`-n` მაჩვენე ხაზი რომელზეც იპოვე <br>
`-c` დაითვალე რამდენს იპოვი <br>
`-v` მანახე რაც არ დაემთხვევა <br>



## ფაილში ძებნა
```bash
grep 'error' logfile.txt
```

## საქაღალდეში ძებნა
```bash
grep -r 'pattern' directory/
```
