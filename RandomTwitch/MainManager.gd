extends Control

export(NodePath) onready var twitch_client = get_node(twitch_client)
export(NodePath) onready var user_list = get_node(user_list)
export(NodePath) onready var data_list = get_node(data_list)
export(NodePath) onready var roll_button = get_node(roll_button)
export(NodePath) onready var selected_user_data = get_node(selected_user_data)
export(String) var secret_path

var users = {}

export(float) var roll_time = 5.0
export(float) var roll_speed_initial = 100.0
export(float) var roll_speed_end = 100.0

var rolling = false
var cur_rolling_time = 0.0
var cur_roll = 0.0

func _ready():
	roll_button.connect('pressed', self, 'on_roll_button_pressed')

	var secret_file = File.new()
	secret_file.open(secret_path, File.READ)
	var password = secret_file.get_line()
	var client_id = secret_file.get_line()

	twitch_client.IRC_CHANNEL = "blackcatest"

	twitch_client.CLIENT_NICK = "NyanestBot"
	twitch_client.CLIENT_REALNAME = "NyanBot"

	twitch_client.CLIENT_ID = client_id
	twitch_client.CLIENT_PASSWORD = password

	twitch_client.connect("message_recieved", self, "on_message_recieved")

	twitch_client.start()

func on_message_recieved(user, color, message):
	if not message.begins_with('!do'):
		return

	var data = message.substr(4, message.length() - 4)
	if not users.has(user):
		users[user] = []
		user_list.add_item(user)

	users[user].append(data)
	data_list.add_item(user + ": " + data)

func _process(delta):
	if not rolling:
		return

	if cur_rolling_time > roll_time:
		rolling = false
		selected_user_data.self_modulate = Color.green
		return

	cur_rolling_time += delta

	var roll_coef = ease((roll_time - cur_rolling_time) / roll_time, 1.0) * roll_speed_initial + roll_speed_end
	cur_roll += roll_coef * delta
	if cur_roll > 1.0:
		select_random()
		cur_roll = 0.0

func select_random():
	var selected_user_index = randi() % users.keys().size()
	user_list.select(selected_user_index)
	var user = users.keys()[selected_user_index]

	var datas = users[user]
	var selected_data_index = randi() % datas.size()
	var data = datas[selected_data_index]
	selected_user_data.text = user + "\n" + data
	var data_in_search = user + ": " + data
	for i in range(data_list.get_item_count()):
		var data_text = data_list.get_item_text(i)
		if data_text == data_in_search:
			data_list.select(i)
			break

func on_roll_button_pressed():
	selected_user_data.self_modulate = Color.white

	if users.empty():
		return

	randomize()

	rolling = true
	cur_rolling_time = 0.0
	cur_roll = 0.0
