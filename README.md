## Basics
ყველა სკრიფტი უნდა იწყებოდეს ე.წ. `shebang`-ით, რადგანაც ის მიუთითებს თუ რითი უნდა გაიხსნას მის ქვემოთ დაწერილი სკრიფტი.
```bash
#!/bin/sh
```
ასევე ყველა სკრიფტის ფაილის უნდა ჰქონდეს შესრულების უფლება
```bash
sudo chmod +x filename.sh
```

## ცვლადები
ცვლადის სახელები უნდა შეცავდეს მხოლოდ [a-zA-Z0-9_] სიმბოლოებს, 
ცვლადის სახელებს ასევე კონვენციის მიხედვით წერენ UPPERCASE-ით

```bash
NAME="David"
AGE=31
echo "Hello, my name is $NAME and I'm $AGE years old! "
```
### (**Read-only**) ანუ ცვლადების გადაქცევა კონსტანტებად

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
## სპეციალური ცვლადები


| # 	| ცვლადი 	| აღწერა 	|
|---	|:------:	|--------	|
| 1  	|   $0  	|     სკრიფტის ფაილის სახელი   	|
|   2	|   $n    |    პოზიციური არგუმენტები რომლებიც გადაეცემა სკრიფტს შესრულების დროს. $1 პირველი არგუმენტია $2 მეორე და ა.შ.    	|
| 3  	|   $#    |      არგუმენტების რაოდენობა რომელიც გადაეცა სკრიფტს 	|
| 4  	|   $*    |     იღებს ყველა არგუმენტს ერთი სტრიქონის სახით   	|
| 5  	|   $@    |       იღებს ყველა არგუმენტს ცალ-ცალკე სტრიქონებად 	|
| 6  	|   $?    |      წინა შესრულებული/დასრულებული პროგრამის დამთავრების სტატუსი  	|
| 7  	|   $$    |   მიმდინარე `shell`-ის პროცესის ID     	|
| 8  	|   $!    |     ბოლო ბრძანების ნომერი რომელიც მიმდინარეობდა ფონურ რეჟიმში  	|

## მასივები


```bash
NUMBERS[0]="ნული"
NUMBERS[1]="ერთი"
NUMBERS[2]="ორი"
NUMBERS[3]="სამი"
NUMBERS[4]="ოთხი"

# NUMBERS=("zero" "one" "two") # ალტერნატიული სინტაქსი

echo "ჩამონათვალის პირველი ელემენტი ${NUMBERS[0]}" # ერთის დაბეჭდვა
echo "ჩამონათვალის ყველა ელემენტი ${NUMBERS[*]}" # ყველას დაბეჭდვა
echo "ჩამონათვალის ყველა ელემენტი ${NUMBERS[@]}" # ყველას დაბეჭდვა
```
## ოპერატორები
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




<!-- https://www.tutorialspoint.com/unix/unix-using-arrays.htm -->
