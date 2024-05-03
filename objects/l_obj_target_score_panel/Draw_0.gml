event_inherited();

if(panel_opened)
{
	draw_set_font(l_font_day_dream);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
	
draw_set_color(c_yellow);
draw_text_transformed(x + 15, y + 35, "Needed Score:", image_yscale * text_scale / 1.8, image_yscale * text_scale / 1.8, 0);
draw_text_transformed(x + 15, y + 85, string(global.game.needed_score), image_yscale * text_scale, image_yscale * text_scale, 0);
draw_set_color(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
}

