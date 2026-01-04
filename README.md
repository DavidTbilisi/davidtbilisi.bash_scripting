თარგმნილია [tutorialspoint.com](https://www.tutorialspoint.com/unix/shell_scripting.htm)-დან

დამატებითი რესურსები:  
- [Linux Course](https://linuxcourse.rutgers.edu/html/Lesson_1.html)
- [Linux for programmers](https://youtube.com/playlist?list=PLTnRtjQN5iea6LlzIpcX5M4Av4JBPEiHm&si=_D1o1POuAhSPYeCN)
- [Online bash](https://www.onlinegdb.com/online_bash_shell)
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)

## რატომ უნდა ვისწავლო Shell Scripting-ი?
- კომპიუტერის ავტომატიზაცია
- კომპიუტერის მართვა
- პატარ-პატარა ტასკების დაჯგუფება
- უმეტესწილად უფრო ლაკონურია ვიდრე პითონი
- შეგვიძლია ასევე პითონთან ერთად გამოყენება


## Built-ins

`compgen -k` - გვიბრუნებს ჩაშენებული keyword-ების მნიშვნელობას


## Basics

[Shell script basics](https://youtu.be/EbyA5rZwyRw?si=CbmbtTzSbkZ3zTUQ)

ყველა სკრიფტი უნდა იწყებოდეს ე.წ. `shebang`-ით, რადგანაც ის მიუთითებს, თუ რომელი პროგრამის მეშვეობით უნდა გაიხსნას მის ქვემოთ დაწერილი სკრიფტი.
```bash
#!/bin/bash
```
იმის სანახავად თუ რომელ bash -ს იყენებს ტერმინალი (რათა შემდგომ, მივუთითოთ იგივე პროგრამა shebang-ის გვერდით) შეიძლება გამოვიყენოთ ბრძანება: 
```bash 
echo $SHELL
``` 

ასევე ყველა სკრიფტის ფაილის უნდა ჰქონდეს შესრულების უფლება
```bash
sudo chmod +x filename.sh
```
ალტერნატიულად 
```bash
sudo chmod 744 filename.sh
# 7 = 4 + 2 + 1
# 4 - read
# 2 - write
# 1 - execute
```

გარემოები
---
`.bash_profile` ავტომატურად ეშვება კომპიუტერის ჩართვისას, ან ssh -ით შესვლისას
- ეშვება მხოლოდ ერთხელ (მოწყობილობის Login -ის დროს)
- ძირითადად ამ ფაილში ინახება ცვლადი PATH (რომელიც სხვადასხვა პროგრამების მისამართებს ინახავს, რათა ისინი ხელმისაწვდომი იყვნენ ყველა მისამართიდან) 

`.bashrc` ავტომატურად ეშვება ახალი bash ფანჯრის გახსნისას.
- ეშვება ყოველი shell -ის გახსნისას.
- ძირითადად ამ ფაილში ინახება მოკლე დასახელებები ანუ alias

`.profile` 
- იგივეა რაც `.bash_profile` მაგრამ მას იყენებენ სხვადასხვა პროგრამები. ისეთები როგორიც sh, ksh, bash...

## ცვლადები
ცვლადის სახელები უნდა შეცავდეს მხოლოდ [a-zA-Z0-9_] სიმბოლოებს, 
ცვლადის სახელებს ასევე კონვენციის მიხედვით წერენ UPPERCASE-ით

**_ცვლადების გამოცხადებისას მინიჭების სიმბოლოს (=) მარცხნიდან და მარჯვნიდან_** არ უნდა იყოს დაშორება.

```bash
NAME="David"
AGE=31
echo "Hello, my name is $NAME and I'm $AGE years old! "
```
### **Read-only** ანუ კონსტანტები

```bash
NAME="David"
AGE=31
readonly NAME
echo "Hello, my name is $NAME and I'm $AGE years old! "
```

### ცვლადების წაშლა
ასეთ შემთხვევაში სკრიფტი არაფერს დაბეჭდავს.
შეუძლებელია `unset` ბრძანებით `readonly` ცვლადის წაშლა
```bash
NAME="David"
unset NAME
echo $NAME
```
### ცვლადები და [გარემო](https://youtu.be/yM8v5i2Qjgg?si=M06tEOSThU8hb33j&t=282)

ლოკალური ცვლადები რომლებიც ჩანს მხოლოდ ერთ ფანჯერაში შეგვიძლია დავწეროთ ჩვეულებრივად 

```bash 
VAR="Value"
```
ხოლო თუ გვინდა ცვლადს სხვა ფანჯრიდანაც მივწვდეთ, მაშინ წინ უნდა მივუწეროთ keyword-ი `export`: 


```bash 
export VAR="Value"
```

```bash 
declare -x Var="Value"
```

### Declare 
გვაძლევს ცვლადის შექმნის საშუალებას. 

```bash 
declare -r Value=3
Value=1  # Error Value: readonly variable 
echo $Value
```

```bash
declare -i number
number=1+2  # The result is 3, not the string "1+2"
```


```bash
declare -a myArray
myArray[0]=Hi
myArray[1]=Hey
echo ${myArray[@]}
```

```bash
# Declares a variable as an associative array (hash map)
declare -A myArray
myArray[0]=Hi
myArray[1]=Hey
echo ${myArray[@]}
```

```bash 
declare -x Value # export Value
```

```bash
declare -l lowercase_var="This Will Be Lowercase"
declare -u uppercase_var="This Will Be Uppercase"
```


## სპეციალური ცვლადები


| # 	| ცვლადი 	| აღწერა 	|
|---	|:------:	|--------	|
| 1  	|   $0  	|     სკრიფტის ფაილის სახელი   	|
| 2	  |   $n    |    პოზიციური არგუმენტები რომლებიც გადაეცემა სკრიფტს შესრულების დროს. $1 პირველი არგუმენტია $2 მეორე და ა.შ.    	|
| 3  	|   $#    |      არგუმენტების რაოდენობა რომელიც გადაეცა სკრიფტს 	|
| 4  	|   $*    |     იღებს ყველა არგუმენტს ერთი სტრიქონის სახით   	|
| 5  	|   $@    |       იღებს ყველა არგუმენტს ცალ-ცალკე სტრიქონებად 	|
| 6  	|   $?    |      წინა შესრულებული/დასრულებული პროგრამის დამთავრების სტატუსი  	|
| 7  	|   $$    |   მიმდინარე `shell`-ის პროცესის ID     	|
| 8  	|   $!    |     ბოლო ბრძანების ნომერი რომელიც მიმდინარეობდა ფონურ რეჟიმში  	|


**მაგალითი**

იღებს ყველა არგუმენტს სტრიქონად და იყენებს ["ჩანაცვლებას"](https://github.com/DavidTbilisi/davidtbilisi.bash_scripting?tab=readme-ov-file#%E1%83%9E%E1%83%90%E1%83%A0%E1%83%90%E1%83%9B%E1%83%94%E1%83%A2%E1%83%A0%E1%83%94%E1%83%91%E1%83%98%E1%83%A1-%E1%83%92%E1%83%90%E1%83%A4%E1%83%90%E1%83%A0%E1%83%97%E1%83%9D%E1%83%95%E1%83%94%E1%83%91%E1%83%90)
იმისთვის რომ გადასცეს ყველა არგუმენტი გარდა პირველი ორისა. ( ფაილის სახელისა და პირველი არგუმენტის )

```bash
add_tag() {
	echo tm add "$1" --tags "${@:2}" 
	tm add "$1" --tags "${@:2}"
}
```


## მასივები

### შექმნა
```bash
myarray=("one" "two" "three")
```
### დამატება
```bash
myarray+=("Four")
```
### სიგრძის გაგება


```bash
# ცვლადის სიგრძე
var="David"
echo ${#var} # 5
```

```bash
# მასივის ერთი ელემენტის
echo ${#myarray[0]}
```

```bash
# მასივისის სიგრძე
echo ${#myarray[@]}
```

### იტერაცია (ციკლში გატარება)
```bash
for item in "${my_array[@]}"; do
    echo $item
done
```

### შეცვლა
```bash
my_array[0]="One"
```
### წაშლა
```bash
unset my_array[1]
```

```bash
echo This is my array content ${myarray[*]} length = ${#myarray[@]}
```

## ოპერატორები
[წყარო](https://www.tutorialspoint.com/unix/unix-basic-operators.htm)

მნიშვნელოვანი შენიშვნა:
- ოპეარტორებს შორის უნდა იყოს დაცული მანძილი. მაგალითად `expr 2+2` არ იმუშავებას. სწორია `expr 2 + 2`.
- ბრძანება უნდა იყოს ჩაწერილი ["ბექთიქებში"](https://macautomationtips.com/wp-content/uploads/2015/08/backtick-key-e1439405041467.jpg)

### არითმეტიკული ოპერატორები

| ოპერატორი | აღწერა | მაგალითი |
|---|---|---|
|+ (მიმატება)| კრებს ოპერატორებს | `expr $a + $b` |
|- (გამოკლება)| აკლებს ოპერატორებს | `expr $a - $b` |
|* (გამრავლება)| ამრავლებს ოპერატორებს | `expr $a \* $b` |
|/ (გაყოფა)| კრებს ოპერატორებს | `expr $a / $b` |
|% (მოდულური გაყოფა)| კრებს ოპერატორებს | `expr $a % $b` |
|= (მინიჭება)| ანიჭებს ცვლადს მნიშვნელობას | `a = $b` |
|== (ტოლობა)| ადარებს ორ რიცხვის იგივეობას | `[ $a == $b ]` |
|!= (უტოლობა)| ადარებს ორ რიცხვის განსხვავებულობას | `[ $a != $b ]` |

### შედარების ოპერატორები

| ოპერატორი | აღწერა | მაგალითი |
|---|---|---|
|-eq| თუ ოპერატორები უდრის, ბრუნდება `true` მნიშვნელობა | `[ $a -eq $b ]` |
|-ne| თუ ოპერატორები არ უდრის, ბრუნდება `true` მნიშვნელობა  | `[ $a -ne $b ]` |
|-gt| თუ მარცხენა ოპერატორი > მარჯვენაზე, ბრუნდება `true` მნიშვნელობა | `[ $a -gt $b ]` |
|-lt| თუ მარცხენა ოპერატორი < მარჯვენაზე, ბრუნდება `true` მნიშვნელობა  | `[ $a -lt $b ]` |
|-ge| თუ მარცხენა ოპერატორი >= მარჯვენაზე, ბრუნდება `true` მნიშვნელობა  | `[ $a -ge $b ]` |
|-le| თუ მარცხენა ოპერატორი <= მარჯვენაზე, ბრუნდება `true` მნიშვნელობა | `[ $a -le $b ]` |

<details>
  <summary>მაგალითები</summary>
  
```bash
#!/bin/sh

a=10
b=20

if [ $a -eq $b ]
then
   echo "$a -eq $b : a is equal to b"
else
   echo "$a -eq $b: a is not equal to b"
fi

if [ $a -ne $b ]
then
   echo "$a -ne $b: a is not equal to b"
else
   echo "$a -ne $b : a is equal to b"
fi

if [ $a -gt $b ]
then
   echo "$a -gt $b: a is greater than b"
else
   echo "$a -gt $b: a is not greater than b"
fi

if [ $a -lt $b ]
then
   echo "$a -lt $b: a is less than b"
else
   echo "$a -lt $b: a is not less than b"
fi

if [ $a -ge $b ]
then
   echo "$a -ge $b: a is greater or  equal to b"
else
   echo "$a -ge $b: a is not greater or equal to b"
fi

if [ $a -le $b ]
then
   echo "$a -le $b: a is less or  equal to b"
else
   echo "$a -le $b: a is not less or equal to b"
fi
```
</details>


<!--  https://youtu.be/bLUyKn7I6b8?t=923 -->

### ბულიან ოპერატორები

| ოპერატორი | აღწერა | მაგალითი |
|---|---|---|
| ! | false-ის უარყოფა გვაძლევს true-ს | [ ! false] |
| -o | OR | [ $a -lt 20 -o $b -gt 100 ] |
| -a | AND | [ $a -lt 20 -a $b -gt 100 ]  |

<details>
  <summary> მაგალითები </summary>
  
  
```bash
#!/bin/sh

a=10
b=20

if [ $a != $b ]
then
   echo "$a != $b : a is not equal to b"
else
   echo "$a != $b: a is equal to b"
fi

if [ $a -lt 100 -a $b -gt 15 ]
then
   echo "$a -lt 100 -a $b -gt 15 : returns true"
else
   echo "$a -lt 100 -a $b -gt 15 : returns false"
fi

if [ $a -lt 100 -o $b -gt 100 ]
then
   echo "$a -lt 100 -o $b -gt 100 : returns true"
else
   echo "$a -lt 100 -o $b -gt 100 : returns false"
fi

if [ $a -lt 5 -o $b -gt 100 ]
then
   echo "$a -lt 100 -o $b -gt 100 : returns true"
else
   echo "$a -lt 100 -o $b -gt 100 : returns false"
fi
```
  
</details>



### სტრიქონის ოპერატორები

| ოპერატორი | აღწერა | მაგალითი |
|:---:|---|---|
|= 	| უდრის თუ არა ორი სტრიქონი ერთმანეთს | 	[ $a = $b ] |
|!= |	თუ სტრიქონები არ უდრის, აბრუნებს true-ს | 	[ $a != $b ] |
|-z |	თუ სტრიქონის სიგრძე უდრის ნულს, აბრუნებს true-ს   |	[ -z $a ] |
|-n |	თუ სტრიქონი არ არის ცარიელი, აბრუნებს true-ს |	[ -n $a ] |
|str| თუ სტრიქონი ცარიელია, აბრუნებს false-ს |	[ $a ] |


## ბრენჩინგი (if else fi)

unix shell-ში გამოიყენება if-ის შემდეგი ფორმები
- if...fi
- if...else...fi
- if...elif...else...fi


<details> 
  <summary> მაგალითი </summary>
  
  ```bash
  #!/bin/sh

a=10
b=20

if [ $a == $b ]
then
   echo "a is equal to b"
elif [ $a -gt $b ]
then
   echo "a is greater than b"
elif [ $a -lt $b ]
then
   echo "a is less than b"
else
   echo "None of the condition met"
fi
  ```
</details>


ასევე შესაძლებელია case-ის გამოყენება
- case...esac


<details> 
  <summary> მაგალითი </summary>
  
  ```bash
#!/bin/sh

FRUIT="kiwi"

case "$FRUIT" in
   "apple") echo "Apple pie is quite tasty." 
   ;;
   "banana") echo "I like banana nut bread." 
   ;;
   "kiwi") echo "New Zealand is famous for kiwi." 
   ;;
esac
  ```
</details>

## ციკლები
- while loop
- for loop
- until loop
- select loop


### while
```
while command
do
   Statement(s) to be executed if command is true
done
```
```bash
#!/bin/sh

a=0

while [ $a -lt 10 ]
do
   echo $a
   a=`expr $a + 1`
done
```

### for
```bash
#!/bin/sh

for var in 0 1 2 3 4 5 6 7 8 9
do
   echo $var
done
```


```bash
#!/bin/sh

for FILE in $HOME/.bash*
do
   echo $FILE
done
```
### until
```bash
#!/bin/sh

a=0

until [ ! $a -lt 10 ]
do
   echo $a
   a=`expr $a + 1`
done
```


### Select - ინტერაქტიული მენიუს შექმნა

ინტერაქტიიულ მენიუში შეიძლება იყოს მოთავსებული სხვადასხვა ფუნქცია... 


მარტივი მაგალითი.
```
select item in tea cofee water juice appe all none
do
   echo "You have selected ${item}"
done
```


შედარებით კომპლექსური მაგალითი.
```bash
#!/bin/bash
select DRINK in tea cofee water juice appe all none
do
   case $DRINK in
      tea|cofee|water|all) 
         echo "Go to canteen"
         ;;
      juice|appe)
         echo "Available at home"
      ;;
      none) 
         break 
      ;;
      *) echo "ERROR: Invalid selection" 
      ;;
   esac
done
```


```bash
#!/bin/bash

echo "Select a Linux command to learn more about it:"

select cmd in ls pwd cd grep echo find mkdir rmdir touch exit
do
    case $cmd in
        ls)
            echo "ls: List directory contents."
            ;;
        pwd)
            echo "pwd: Print name of current/working directory."
            ;;
        cd)
            echo "cd: Change the shell working directory."
            ;;
        grep)
            echo "grep: Search for patterns in files."
            ;;
        echo)
            echo "echo: Display a line of text."
            ;;
        find)
            echo "find: Search for files in a directory hierarchy."
            ;;
        mkdir)
            echo "mkdir: Make directories."
            ;;
        rmdir)
            echo "rmdir: Remove empty directories."
            ;;
        touch)
            echo "touch: Change file timestamps."
            ;;
        exit)
            echo "Exiting the menu."
            break
            ;;
        *)
            echo "Invalid selection: $REPLY"
            ;;
    esac
done

```
## ჩანაცვლება (Substitution)

`-e`-ს დამატება სტრიქონამდე საშუალებას გვაძლევს ჩავანაცვლოთ ისეთი "escape-იანი სიმბოლოები" როგორიცაა მაგალითად `\n`

```bash
#!/bin/sh

a=10
echo -e "Value of a is $a \n"
```
### ბრძანების ჩანაცვლება
```bash
#!/bin/sh

DATE=`date`
echo "Date is $DATE"

USERS=`who | wc -l`
echo "Logged in user are $USERS"

UP=`date ; uptime`
echo "Uptime is $UP"
```

### ცვლადების ჩანაცვლება

|# |      ფორმა        |                              აღწერა                                                   |
---|-------------------|---------------------------------------------------------------------------------------
1  | `${var}`          | ჩვეულებრივი ჩანაცვლება
2  | `${var:-word}`    | თუ ცვლად var-ს არ აქვს მნიშვნელობა, ის იქნება __ჩანაცვლებული__ word-ის მნიშვნელობით
3  | `${var:=word}`    | default მნიშვნელობის __მინიჭება__. (if not set echo word)
4  | `${var:+word}`    | თუ ცვლად var-ს __აქვს__ მნიშვნელობა, ის იქნება __ჩანაცვლებული__ word-ის მნიშვნელობით
5  | `${var:?message}` | თუ ცვლად var-ს არ აქვს მნიშვნელობა, message იქნება დაპრინტული standard error ში

**მაგალითები:**

მაგალითი 1 - ჩვეულებრივი ჩანაცვლება
```bash
greeting="Hello, world!"
echo $greeting  # Outputs: Hello, world!
```

მაგალითი 2 - თუ ცვლად არ აქვს მნიშვნელობა
```bash
echo "Welcome, ${username:-Guest}"
```
მაგალითი 3 - თუ ცვლად არ აქვს მნიშვნელობა
```bash
echo ${path:=/usr/bin}
echo $path  # Outputs: /usr/bin
```
მაგალითი 4 - ალტერნატიული მნიშვნელობა
```bash
isLoggedIn=true
echo "Status: ${isLoggedIn:+Logged In}"
```
მაგალითი 5 - შეცდომის შეტყობინების ჩანაცვლება
```bash
echo "Configuration file: ${configFile:?"is not set"}"
```


### არითმეტიული ჩანაცვლება
```bash
result=$((3 + 2))
echo $result  # Output: 5
```

### ფიგურილი ფრჩხილების გაფართოება
```bash
echo {1..5}  # Output: 1 2 3 4 5
```


### პარამეტრების გაფართოვება
```bash
text="hello world"
# ${ცვლადი:პოზიცია:სიგრძე}
echo ${text:6:5}  # Output: world
```

```bash
text="hello world"
# ${ცვლადი:ძიება:ჩანაცვლება}
echo ${text/o/O}  # Output: hellO world
```

```bash
text="hello world"
# ${ცვლადი:პოზიცია:სიგრძე}
echo ${text//o/O}  # Output: hellO wOrld
```


## ფუნქციები


```bash
#!/bin/bash

# ფუნქციის შექმნა
Hello () {
   echo "Hello World"
}

# ფუნქციის გამოძახება
Hello
```

```bash

#!/bin/sh

# პარამეტრებიანი ფუნქციის შექმნა
Hello () {
   echo "Hello $1 and $2"
}

# ფუნქციის გამოძახება
Hello David Mevid
```
```bash

#!/bin/sh

# პარამეტრებიანი ფუნქციის შექმნა
Hello () {
   echo "Hello $1 and $2"
   return 10
}

# ფუნქციის გამოძახება
Hello David Mevid

# ბოლო ბრძანების მნიშვნელობის მიღება
ret=$?

echo "დაბრუნებული მნიშვნელობა = $ret"

# ფუნქციის წაშლა
unset -f Hello
```
იმისთვის რომ ფუნქცია იყოს ხელმისაწვდომი სხვა ფანჯრებშიც

```bash 
export -f Hello
```
### Function with default arguments

```bash
greet_user() {
    local name=${1:-"Guest"}
    echo "Welcome, $name!"
}

greet_user  # Output: Welcome, Guest!

```
---

# Repositories

ფორმატი
deb http://http.kali.org/kali kali-rolling main non-free conrib
{ფორმატი} {ლინკი} {გამოშვების ვერსია} {გაიდლაინების გათვალისწინება}

## გაიდლაინები DFSG (Debian Free Software Guidelines)
main - დაცულია ყველა წესი
contrib - თავად პაკეტში დაცულია ყველა წესი, თუმცა დამოკიდებულია პაკეტებზე, რომლებიც არ იცავენ ყველა წესს
non-free - არ არის დაცული წესები


ლინუქსის კონკრეტული __გამოშვების ვერსიის__ სახელის სანახავად LSB (Linux Standard Base)
```bash 
lsb_release -a 
```
## პაკეტების მისამართი

```bash 
cd /etc/apt
ls -l 
```
## რეპოს დამატება
```bash
sudo add-apt-repository ppa:libreoffice/ppa
```
```bash
sudo add-apt-repository 'deb http://archive.getdeb.net/ubuntu wily-getdeb games'
```

## რეპოს წაშლა
```bash
 sudo add-apt-repository --remove ppa:jonathonf/ffmpeg-4
```

## რეპოს სრულად წაშლა
(კონფიგურაციებით, სეთინგებით, დამოკიდებულებებით)
```bash
ppa-purge ppa:jonathonf/ffmpeg-4
```

## apt update
apt update
- get არის განსხვავება timestamps-ებს შორის, შესაბამისად განახლება გადმოწერადია
- hit არ არის განსხვავება timestamps-ებს შორის, შეამოწმა, მაგრამ განახლება არ არის
- ign არ არის განსხვავება pdiff index file-ებში, სავარაუდოდ მიტოვებული რეპო

## Exit Status
[GNU docs](https://www.gnu.org/software/bash/manual/html_node/Exit-Status.html)
[Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/exitcodes.html)
[C Docs](https://man7.org/linux/man-pages/man3/sysexits.h.3head.html)

ერთადერთი საშუალება რომელიც გვანახებს რამდენად სწორად იმუშავა სკრიპტმა. 

`0` → success <br>
`1–255` → failure (or special meaning) <br>

სკრიპტის შესრულების მერე სტატუსი ინახება სპეციალურ ცვლადში `$?`
```bash
$0 # 2 → error
```
გამოიყენება `if-else` -შიც
```bash
if grep -q "admin" users.txt; then
  echo "found admin"
fi
```



















