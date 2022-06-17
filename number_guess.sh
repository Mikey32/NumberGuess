#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RANDOM_NUMBER=$[ $RANDOM % 1000 + 1 ]

GUESS_COUNT=1
GUESS_NUMBER() {
if [[ ! $1 =~ ^[0-9]+$ ]]
then
  echo "That is not an integer, guess again:"
  read GUESS
  GUESS_NUMBER $GUESS
elif [[ $1 -lt $RANDOM_NUMBER ]]
then
  echo "It's higher than that, guess again:"
  ((GUESS_COUNT=GUESS_COUNT+1))
  read GUESS
  GUESS_NUMBER $GUESS
elif [[ $1 -gt $RANDOM_NUMBER ]]
then
  echo "It's lower than that, guess again:"
  ((GUESS_COUNT=GUESS_COUNT+1))
  read GUESS
  GUESS_NUMBER $GUESS
else #[[ $1 == $RANDOM_NUMBER ]]
  echo "You guessed it in $GUESS_COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
  # set variables
  if [[ $GUESS_COUNT -lt $BEST_GAME || -z $BEST_GAME ]]
  then
      BEST_GAME_UPDATED=$($PSQL "UPDATE user_info SET best_guess = $GUESS_COUNT WHERE user_id = $USER_ID")
  fi
  ((GAMES_PLAYED=GAMES_PLAYED+1))
  GAMES_PLAYED_UPDATED=$($PSQL "UPDATE user_info SET games_played = '$GAMES_PLAYED' WHERE user_id = $USER_ID")
fi
}


echo "Enter your username:"
read USER_NAME
USER_ID=$($PSQL "SELECT user_id FROM user_info WHERE name = '$USER_NAME'")
if [[ -z $USER_ID ]]
then
  echo "Welcome, $USER_NAME! It looks like this is your first time here."
  USER_INSERTED=$($PSQL "INSERT INTO user_info(name) VALUES('$USER_NAME')")
  GAMES_PLAYED=0
  BEST_GAME=5000
  USER_ID=$($PSQL "SELECT user_id FROM user_info WHERE name = '$USER_NAME'")
else
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM user_info WHERE user_id = '$USER_ID'")
  BEST_GAME=$($PSQL "SELECT best_guess FROM user_info WHERE user_id = '$USER_ID'")
  echo -e "Welcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.\n"
fi
echo "Guess the secret number between 1 and 1000:"
read GUESS
GUESS_NUMBER $GUESS