// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function deselect_playable(){
	global.playable_selected_card = noone;
	for(var _i = 0;_i<ds_list_size(playable_list);_i++){
		playable_list[|_i].selected = false;
		playable_list[|_i].potential = false;
	}
}