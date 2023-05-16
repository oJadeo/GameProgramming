extends Node

func intersection(a,b,h):
	# a bottom, b top
	if a[0] == b[0]:
		return Vector2(a[0],a[1]+h)
	else:
		return Vector2(a[0]+h*(b[0]-a[0])/(b[1]-a[1]),a[1]+h)
	
func draw_hori(top_l,top_r,btm_l,btm_r,h):
	var inter_l = intersection(btm_l,top_l,h)
	var inter_r = intersection(btm_r,top_r,h)
	return [inter_l,inter_r]

func midpoint(top_l,top_r,btm_l,btm_r):
	var a = top_l[0] - btm_l[0]
	var b = top_r[0] - btm_l[0]
	var d = btm_r[0] - btm_l[0]
	var p = top_l[1] - btm_l[1]
	var x = b*d/(b+d-a)
	var y = p*x/b
	return Vector2(x+btm_l[0],y+btm_l[1])

func i2f(v):
	return Vector2(float(v[0]),float(v[1]))
	
func calculateGrid(top_l,top_r,btm_l,btm_r,h_grid,v_grid):
	#print(top_l,top_r,btm_l,btm_r,h_grid,v_grid)
	top_l = i2f(top_l)
	top_r = i2f(top_r)
	btm_l = i2f(btm_l)
	btm_r = i2f(btm_r)
	h_grid = float(h_grid)
	v_grid = float(v_grid)
	
	var to_draw = []
	to_draw.append([top_l,top_r])
	to_draw.append([top_l,btm_l])
	to_draw.append([top_r,btm_r])
	to_draw.append([btm_l,btm_r])

	var h_lines = [top_l[1]]
	var a = top_r[0]-top_l[0]
	var b = btm_r[0]-btm_l[0]
	for i in range(v_grid-1):
		var ii = float(v_grid - 2 - i)
		var hh = (top_r[1]-btm_r[1])/(1.0+(a/b)*((v_grid-1-ii)/(ii+1)))
		var x = draw_hori(top_l,top_r,btm_l,btm_r,hh)
		to_draw.append(x)
		h_lines.append(hh+btm_l[1])
	h_lines.append(btm_l[1])

	var v_lines = [[btm_l,top_l]]
	for i in range(h_grid-1):
		var ta = Vector2(top_l[0]+(i+1)/h_grid*(top_r[0]-top_l[0]),top_l[1])
		var tb = Vector2(btm_l[0]+(i+1)/h_grid*(btm_r[0]-btm_l[0]),btm_l[1])
		to_draw.append([ta,tb])
		v_lines.append([tb,ta])
	v_lines.append([btm_r,top_r])

	var grid_pos = []
	var g
	for i in range(v_grid):
		g = []
		for j in range(h_grid):
			var tl = intersection(v_lines[j][0],v_lines[j][1],h_lines[i]-btm_l[1])
			var tr = intersection(v_lines[j+1][0],v_lines[j+1][1],h_lines[i]-btm_l[1])
			var bl = intersection(v_lines[j][0],v_lines[j][1],h_lines[i+1]-btm_l[1])
			var br = intersection(v_lines[j+1][0],v_lines[j+1][1],h_lines[i+1]-btm_l[1])
			var x = midpoint(tl,tr,bl,br)
			g.append(x)
		grid_pos.append(g)
	return [to_draw,grid_pos]
