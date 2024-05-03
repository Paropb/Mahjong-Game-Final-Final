//UI
	global.game = id;

	global.ButtonDepth = -9999;
	global.PanelDepth = -10000;

	screenCenterX = view_xview[0] + view_wview[0] / 2;
	screenCenterY = view_yview[0] + view_hview[0] / 2;
	
	wining_hands_array =
	[
		{
			name : "STRAIGHT",
			sprite : spr_straight_flush,
			//m_score: 
		},
		{
			name : "4 Of A KIND",
			sprite : _4_Of_A_Kind,
			//m_score: 
		},
		{
			name : "STRAIGHT 4",
			sprite : Straight_4,
			//m_score: 
		},
		
		{
			name : "3 Of A KIND",
			sprite : _3_Of_A_Kind,
			//m_score: 
		},
		{
			name : "STRAIGHT 3",
			sprite : Straight_3,
			//m_score: 
		},
		
		//{
			//name: "PENG"
		//}
	]

	//playable list
	playable_deck_offset_x = 22;
	playable_deck_offset_y = 0;

	//deck list
	deck_offset_x = 22;
	deck_offest_y = 350;
	
	//player list
	player_deck_offset_x = 22;
	player_deck_offset_y = -200;

	//Spacing
	card_spacing = 50;
	
	//Card Scale
	card_scale_x = 1.5;
	card_scale_y = 1.5;
	
	function DrawCard()
	{
		
		game_state = "discard";
		UpdateUI();
	}
	function DiscardPlayable()
	{
		discard_playable();
		should_draw = true;
		game_state = "play";
	}
	function PlayCard()
	{
		global.multi_select_player = true;
			var tmp_result = check_potential();
			show_debug_message(string(tmp_result));
			switch(tmp_result){
				//nothing happen
				case 0:
					deselect_player();
					deselect_playable();
					find_potential();
					//game_state = "play";
					break;
				case 1:
					//kong
					draw_hands(3);
					discard_playable();
					should_draw = true;
					game_state = "play";
					
					break;
				case 2: 
					//pung or chow
					//global.multi_select_player = false;
					draw_hands(2);
					discard_playable();
					should_draw = true;
					game_state = "play";
					
					break;
				case 3:
				
					draw_hands(4);
					discard_playable();
					should_draw = true;
					game_state = "play";
					
					break;
			}
			
			/*draw_hands(draw_amount);
			discard_playable();
			game_state = "play";*/

		UpdateUI();
	}
	function DiscardCard()
	{	
		var draw_amt = 0;

		for (var _i = ds_list_size(player_list)-1; _i >= 0; _i--){
			if(player_list[|_i].selected){
				draw_amt++;
			}
		}
		if(draw_amt<=5){
			discard_selected();
			global.multi_select_player = true;
			game_state = "play";
			draw_hands(draw_amt);
		}else{
			deselect_player();
		}
		
		
		UpdateUI();
	}
	function OpenShop()
	{
		
	}
//End UI

//SFX
theme_bgm = snd_theme_bgm;
//End SFX

draw_set_color(c_white);

//keep track of game state
game_state = "decision";
game_score= 0;
needed_score = 1500;

should_draw = true;

straight_score = 800;
kong_score = 600;
pung_score = 300;
chow_score = 200;

//determine winning hand helper
num_triplet = 0;
//template for all zero array up to 29
//
tmp_card_template = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

card_tracker =  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

randomize();

//whenever player want to play a hand, draw N card from deck
//if there is a chow, pung or kong, player can decide whether to do it
//after that, the set become fixed, and the rest of the playable hand go
//into the discard deck

//all decks 

//general deck
deck_list = ds_list_create();
//player's hand
player_list = ds_list_create();
//playable cards that can be use as chow, pung or kong
playable_list = ds_list_create();
//scoring hands goes into a separate space
score_list = ds_list_create();
//check potential triplets helpers
potential_list = ds_list_create();
//discard pile
discard_list = ds_list_create();

//array names for mahjong hands
mahjong_hands = [
	[],
	["", "Dot 1","Dot 2", "Dot 3", "Dot 4", "Dot 5", "Dot 6", "Dot 7", "Dot 8", "Dot 9" ],
	["", "Bamboo 1 ", "Bamboo 2", "Bamboo 3", "Bamboo 4", "Bamboo 5", "Bamboo 6", "Bamboo 7", "Bamboo 8", "Bamboo 9" ],
	["", "Wan 1", "Wan 2", "Wan 3", "Wan 4", "Wan 5", "Wan 6", "Wan 7", "Wan 8", "Wan 9" ],
	["", "East Wind", "South Wind", "West Wind", "North Wind"],
	["", "Red Dragon", "Green Dragon" , "White Dragon"]
];

//coordinates for all decks

//separation between cards
global.card_separation = 50;
draw_amount = 1;
playable_amount = 6;
total_score = 0;
//coordinate for general deck
general_xpos = 50;
general_ypos = 50;
//coordinate for player hands
player_xpos = 50;
player_ypos = 650;
//coordinate for discard list
discard_xpos = 50;
discard_ypos = 450;
//coordinate for playable list
playable_xpos = 50;
playable_ypos = 250;
//coordinate for scoring triplet
score_xpos = 50;
score_ypos = 850;



//helper boolean for multi-select

//by default, you can select multiple hands in player hands
global.multi_select_player = true;
global.player_selected_card = noone;

//by default, you can't select multiple hands in playable pool
global.multi_select_playable = false;
global.playable_selected_card = noone;



//generate the general deck
generate_deck();

//shuffle the deck
shuffle_deck(deck_list,general_xpos,general_ypos);

//draw_starting_hand
draw_starting_hands();

alarm[0] = 1;




