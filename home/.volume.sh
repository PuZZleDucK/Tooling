#!/bin/bash

amixer get Master | grep Left | egrep -o "[0-9]+%"
amixer get Master | grep Mono | egrep -o "[0-9]+%"

