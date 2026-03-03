shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(1.0); // Цвет обводки
uniform float line_thickness : hint_range(0, 10) = 1.0; // Толщина в пикселях

void fragment() {
    vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
    float outline = 0.0;
    
    // Проверка соседних пикселей в 4-х или 8-и направлениях
    outline += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
    outline += texture(TEXTURE, UV - vec2(size.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
    outline += texture(TEXTURE, UV - vec2(0.0, size.y)).a;
    
    // Ограничиваем значение и убираем обводку там, где уже есть основной спрайт
    outline = min(outline, 1.0);
    
    vec4 color = texture(TEXTURE, UV);
    COLOR = mix(color, line_color, outline - color.a);
}