extends Node

var key = 0
var apple_collected = 0
var banana_collected = 0
var cherry_collected = 0
var orange_collected = 0
var melon_collected = 0

signal fruit_collected

func collect_fruit(name: String):
	if name == "apple":
		apple_collected += 1
	elif name == "banana":
		banana_collected += 1
	elif name == "cherry":
		cherry_collected += 1
	elif name == "orange":
		orange_collected += 1
	elif name == "melon":
		melon_collected += 1
	fruit_collected.emit()

func collect_key():
	key += 1

func use_key(keys_needed: int):
	key -= keys_needed

func lost_fruit():
	apple_collected = 0
	banana_collected = 0
	cherry_collected = 0
	orange_collected = 0
	melon_collected = 0
