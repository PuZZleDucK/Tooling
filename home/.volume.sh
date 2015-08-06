#!/bin/bash

amixer get Master | grep Left | egrep -o "[0-9]+%"

