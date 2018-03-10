tool
extends Sprite

enum GenerageMode { IMAGE, SHOW, TRANSFORM, ATL_ONLY }
enum PosMode { FACTOR, PIXEL }

export(String) var name_ = 'name'
export(GenerageMode) var mode = 0
export(Vector2) var factor_pos = Vector2(0.5, 1) setget set_factor_pos
export(Vector2) var anchor = Vector2(0.5, 1.0) setget set_anchor

export(PosMode) var pos_mode = 0
export(bool) var print_atl = false setget set_print_atl

const DEFAULTS = {
	'pos': Vector2(0.5, 1),
	'anchor': Vector2(0.5, 1.0),
	'zoom': Vector2(1, 1),
	'rotate': 0.0,
	'alpha': 1.0
}

var prev_pos

func _ready():
	print(generate_atl())
	prev_pos = position
	call_deferred('update_all')

func _process(delta):
	if position != prev_pos:
		prev_pos = position
		set_factor_pos(prev_pos/get_viewport_rect().size, false)

func set_print_atl(b):
	print(generate_atl())
	print_atl = false

func update_all():
	update_factor_pos()
	update_anchor()

func set_factor_pos(p, update=true):
	factor_pos = p
	if update:
		call_deferred('update_factor_pos')

func update_factor_pos():
	position = get_viewport_rect().size * factor_pos
	prev_pos = position
	update()

func set_anchor(a):
	anchor = a
	call_deferred('update_anchor')

func update_anchor():
	if region_enabled:
		offset = (region_rect.size-region_rect.position) * -anchor
	else:
		offset = texture.get_size() * -anchor


func float_factor(f):
	if floor(f) == f:
		return '%.1f' % f
	return '%s' % f

func vec2_factor(v2):
	return '(%s, %s)' % [float_factor(v2.x), float_factor(v2.y)]

func generate_atl():
	var atl = ""
	var brtab = '\n    '
	if mode == GenerageMode.IMAGE:
		atl += "image %s:" % name_.replace('-', '_')
		atl += '\n    "%s.png"' % name_
	elif mode == GenerageMode.SHOW:
		atl += "show %s:" % name_.replace('-', '_')
	elif mode == GenerageMode.TRANSFORM:
		atl += "transform %s:" % name_.replace('-', '_')
	elif mode == GenerageMode.ATL_ONLY:
		brtab = '\n'
	
	if pos_mode == PosMode.FACTOR:
		if factor_pos != DEFAULTS.pos:
			atl += brtab+'pos %s' % [vec2_factor(factor_pos)]
	else:
		atl += brtab+'pos (%.f, %.f)' % [position.x, position.y]
	
	if anchor != DEFAULTS.anchor:
		atl += brtab+'anchor %s' % [vec2_factor(anchor)]
	
	if scale != DEFAULTS.zoom:
		if scale.x != scale.y:
			atl += brtab+'xzoom %s yzoom %s' % [scale.x, scale.y]
		else:
			atl += brtab+'zoom %s' % [scale.x]
	
	if rotation_degrees != DEFAULTS.rotate:
		atl += brtab+'rotate %s' % rotation_degrees
	
	if modulate.a != DEFAULTS.alpha:
		atl += brtab+'alpha %s' % modulate.a
	
	if region_enabled:
		var p = region_rect.position
		var s = region_rect.size
		atl += brtab+'crop (%s, %s, %s, %s)' % [p.x, p.y, s.x, s.y]
	
	return atl
