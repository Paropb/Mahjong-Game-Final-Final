show_button = true;
function CheckOpenState(gamestate)
{
	if(gamestate == according_gamestate || according_gamestate == "all")
	{
		show_button = true;
	}
	else
	{
		show_button = false;
	}
}


