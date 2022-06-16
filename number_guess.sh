#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RANDOM_NUMBER = $(( $RANDOM % 1000 + 1 ))
GUESS_COUNT = 0
echo "Enter your username:"
read USER_NAME
USER_ID=$($PSQL "SELECT user_id FROM user_info WHERE name = '$USER_NAME'")
if [[ -z $USER_ID ]]
then
  echo "Welcome, $USER_NAME! It looks like this is your first time here."
  USER_INSERTED=$($PSQL "INSERT INTO user_info(name) VALUES('$USER_NAME')")
  GAMES_PLAYED=0
  BEST_GAME=5000
else
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM user_info WHERE user_id = '$USER_ID'")
  BEST_GAME=$($PSQL "SELECT best_guess FROM user_info WHERE user_id = '$USER_ID'")

fi
echo "Guess the secret number between 1 and 1000:"
read GUESS
GUESS_NUMBER(GUESS)
GUESS_NUMBER{
if [[ $1 -gt RANDOM_NUMBER ]]
then
  echo "It's higher than that guess again:"
  $GUESS_COUNT = $GUESS_COUNT + 1
  read GUESS
  GUESS_NUMBER(GUESS)
elif [[ $1 -lt $RANDOM_NUMBER ]]
  echo "It's lower than that guess again:"
  $GUESS_COUNT = $GUESS_COUNT + 1
  read GUESS
  GUESS_NUMBER(GUESS)
elif [[ $1 == $RANDOM_NUMBER ]]
  echo "You gessed it in $GUESS_NUMBER tries. The secret number was $RANDOM_NUMBER. Nice job!"
  # get lowest number of guesses
  # if current guess_number is lower then replace
  INFO_INSERTED=$($PSQL "INSERT INTO
}

