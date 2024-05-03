// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function deselect_player(){
	for(var _i = 0;_i<ds_list_size(player_list);_i++){
		player_list[|_i].selected = false;
	}
}