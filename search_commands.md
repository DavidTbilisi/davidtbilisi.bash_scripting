# LOCATE
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





# FIND
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
