# OL Simple Aritmetic calculator with proper and improper fractions

Ruby 2.6.6

## Constraints

Legal operators  *, /, +, - 

Operands and operators separated by one or more spaces

Mixed numbers will be represented by whole_numerator/denominator. e.g. "3_1/4"

Improper fractions and whole numbers are also allowed as operands 

1/2 * 3_3/4

2_3/8 + 9/8

## Tools

### State machine / automata

1. AASM gem to model and manage first phase of the problem  as state machines (check if an expression is valid and separate tokens as operands / opertors).


1. Using the state machine concept, an automata can be modeled to check expressions. In the image below the automata to check if an expression is valid is given.

![alt text](https://i.ibb.co/8xNZZh3/Untitled-Diagram-1.png)


There are many restrictions in this diagram. For example in the code we handle the logic of only pass once to _ or / and also allow only pass to _ if no / is present
### Tokenization and expression tree

1. Once we have a valid expression then a expression tree is constructed. The input of this step is the list of tokens of the previous step, in the tokenization step 
we change the - operator to + but changing right number multiplying to -1 to avoid wrong results in signed operations. Then an inorder traversal in the token list, i.e. check until a + is find , then separate left and right subtrees (due to precedence of operators) and if no + is find then process the right part of the (*/) to right subtree

![alt text](https://i.ibb.co/LgcSDzB/Untitled-Diagram.png)

### Simplifying fractions

1. Calculatin GCD of two numbers is used to reduce fractions


The operations of + - / * are treated as fractions

a/b + c/d = da + bc / bd

a/b - c/d = da - bc / bd

a/b * c/d = ac / bd

a/b / c/d = ad / bc


## <a name="local"></a> Local Setup

### Set up Ruby

1. Install [RVM](https://rvm.io/rvm/install)

1. Install Ruby

    ```
    rvm install ruby-2.6.6
    ```

1. Gemset for this project
    ```
    rvm --ruby-version --create 2.6.6@simple-calculator
    ```

1. Clone this repository

    ```
    git clone git@github.com:ptorres88/OL_-Arithmetic_Expressions.git
    ```

1. Install bundler

    ```
    gem install bundler
    ```

1. Install gems with bundler

    ```
    bundle install
    ```

1. Run the script

    ```
    irb app/main.rb
    ```

![alt text](https://i.ibb.co/80kqhKf/Captura-de-Pantalla-2021-06-28-a-la-s-9-55-12.png)
    

Note: TTY prompt is used to handle inputs, so if we enter some non ascii keys the program ends (TODO)


## <a name="docker"></a> Docker Setup

1. Clone this repository

1. Install [Docker](https://www.docker.com/products/docker-desktop)

1. Build docker image
    ```
    docker build -t ol_test .
    ```

1. Run docker image
    ```
    docker run -it oltest
    ```

### Tests

#### Run rspec

```
rspec spec/
```

![alt text](https://i.ibb.co/WG8ZbdV/Captura-de-Pantalla-2021-06-28-a-la-s-9-49-22.png)

