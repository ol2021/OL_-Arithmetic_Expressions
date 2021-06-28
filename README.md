# OL TEST

Ruby 2.6.6

# sum

a/b + c/d =  d*a + c*b /b*d ->
a/b - c/d =  d*a - c*b /b*d -> 
a/b * c/d =  a*c /b*d ->
a/b / c/d =  a*d /b*c ->

# expression tree

# aasm
# reduction

![alt text](https://ibb.co/X5jRRwB)
![alt text](https://ibb.co/HPb7LDR)

![alt text](https://i.ibb.co/8xNZZh3/Untitled-Diagram-1.png)
![alt text](https://i.ibb.co/LgcSDzB/Untitled-Diagram.png)


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
    git clone git@github.com:runahr/saas-rails-api.git
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



