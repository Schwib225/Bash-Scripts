#! /bin/bash

echo Enter the new account name:
read newUser

echo Enter their password:
read userPW

useradd -D $newUser $userPW

