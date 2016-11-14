import GUI
var mx, my, xmod, ymod : int:=20
var mx2, my2, xmod2, ymod2 : int:=200


xmod:=12
ymod:=12
xmod2:=5
ymod2:=5

var xx, yy, bb: int 
const C_C := 20

var x, y, b :int 
var ammo : int
ammo:=0

%%%%killscreen
process menu
    View.Update 

delay (1000)
cls
var br :int := Pic.FileNew ("b.jpg") 
Pic.Draw (br,maxx div 5, maxy div 4, 0)
    View.Update 
delay (700)
cls
    View.Update
end menu


%%%%%%%%%%%%%%%%%%%%%%


%%%%%animation d'explosion
proc hit
    View.Update 
cls
var ex :int := Pic.FileNew ("ex.jpg") 
Pic.Draw (ex,mx-80 ,my-100, 0)

fork menu
    View.Update 

end hit




proc hit2
    View.Update 
cls
var ex :int := Pic.FileNew ("ex.jpg") 
Pic.Draw (ex,mx-80 ,my-100, 0)
Pic.Draw (ex,mx2-80 ,my2-100, 0)
fork menu
    View.Update 
    delay (1000)
    var gg :int := Pic.FileNew ("gg.jpg") 
Pic.Draw (gg,maxx div 5, maxy div 4, 0)
end hit2
%%%%%%%%%%%%%%%%%%%




%%%%%%%crosshairs
proc c 


mousewhere (xx,yy,bb)


    drawline (xx - 10, yy, xx - 5, yy, C_C) 
    drawline (xx + 10, yy, xx + 5, yy, C_C) 
    drawline (xx, yy - 10, xx, yy - 5, C_C) 
    drawline (xx, yy + 10, xx, yy + 5, C_C) 


    Draw.ThickLine (xx - 10, yy, xx - 30, yy, 5, C_C) 
    Draw.ThickLine (xx + 10, yy, xx + 30, yy, 5, C_C) 
    Draw.ThickLine (xx, yy - 10, xx, yy - 30, 5, C_C) 
    Draw.ThickLine (xx, yy + 10, xx, yy + 30, 5, C_C) 


    drawoval (xx, yy, 30, 30, C_C) 


    drawfilloval (xx, yy, 3, 3, 12)
end c
%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%1er niveau
proc game

loop 
    c
    setscreen("offscreenonly") 
    View.Update 
    Draw.FillBox(0,0,maxx,maxy,0) 
    Pic.ScreenLoad ("m.jpg", mx, my , picUnderMerge)
    mx+=xmod 
    my+=ymod 
    if mx+70>=maxx then 
	xmod:=-12
	elsif mx<=0 then 
	xmod:=12
    end if 
    if my+95>=maxy then 
	ymod:=-12
	elsif my<=0 then 
	ymod:=12
    end if 

%%hitbox

	    Mouse.Where (x, y, b)  
	if b = 1 and x >= mx+15 and x <= mx+60 and y >= my and y <= my+90 then
	hit
	    View.Update 
    end if

%%%%%
    delay(25) 
	exit when b = 1 and x >= mx+15 and x <= mx+60 and y >= my and y <= my+90
end loop

end game
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc l
cls
var gg :int := Pic.FileNew ("gg.jpg") 
Pic.Draw (gg,maxx div 5, maxy div 4, 0)
end l

%%%%%%%%%%%%%%%%%%2e niveau
proc lvl2
loop 
    c
    setscreen("offscreenonly") 
    View.Update 
    Draw.FillBox(0,0,maxx,maxy,0) 
    
    Pic.ScreenLoad ("m.jpg", mx, my , picUnderMerge)
    mx+=xmod 
    my+=ymod 
    if mx+70>=maxx then 
	xmod:=-8 
	elsif mx<=0 then 
	xmod:=8 
    end if 
    if my+95>=maxy then 
	ymod:=-8
	elsif my<=0 then 
	ymod:=8 
    end if 
    
Pic.ScreenLoad ("m.jpg", mx2, my2 , picUnderMerge)
    mx2+=xmod2 
    my2+=ymod2 
    if mx2+70>=maxx then 
	xmod2:=-4 
	elsif mx2<=0 then 
	xmod2:=4
    end if 
    if my2+95>=maxy then 
	ymod2:=-4
	elsif my2<=0 then 
	ymod2:=4 
    end if 
    View.Update


%%%hitbox
var z : int
z:=0
	    Mouse.Where (x, y, b)  
    if b = 1 and x >= mx+15 and x <= mx+60 and y >= my and y <= my+90 then
    z := z+1
    end if

    if b = 1 and x >= mx2+15 and x <= mx2+60 and y >= my2 and y <= my2+90 then
    z := z+1
    end if
    

    
%%%%%%%%%%%%
if z =2 then
l
end if

	exit when z = 2
end loop


end lvl2
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%startscreen
proc m
    var tt :int := Pic.FileNew ("tt.jpg") 
    Pic.Draw (tt,maxx div 5, maxy div 2, 0)

    var button1:int:=GUI.CreateButton(50,10,0,"PLAY lvl : 1",game) 
    var button2:int:=GUI.CreateButton(500,10,0,"PLAY lvl : 2",lvl2) 
 
	loop 
	exit when GUI.ProcessEvent 
	end loop
end m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
process s
Music.PlayFile ("s.mp3")
end s
fork s
m










