# FlashMapMaker

Editor de mapas para el juego. Una sola página (`index.html`), sin build ni dependencias. Funciona en GitHub Pages.

## Usarlo

- En local: abre `index.html` en el navegador.
- En Pages: Settings → Pages → Deploy from a branch → `main` / `(root)`.

El mapa se autoguarda en el navegador (`localStorage`). Para guardarlo de verdad: **Exportar JSON** y súbelo a `maps/`.

**Mapas del repo** (cabecera) lista lo que haya en `maps/` y lo abre como **copia** (`nombre_copia`), así no pisas el original. Lee el repo a partir de la URL de Pages; en local usa `xNeku/FlashMapMaker`. Con `?repo=owner/nombre` se puede apuntar a otro.

## Controles

| | |
|---|---|
| Rueda | zoom |
| Click derecho / Espacio + arrastrar | mover la vista |
| Arrastrar (suelo/plataforma) | pintar bloques |
| Shift + arrastrar | borrar bloques |
| Ctrl + arrastrar | rellenar rectángulo |
| 1–9, 0 | herramientas |
| Flechas / Supr | mover / borrar la pieza seleccionada |
| L | encender/apagar la bombilla seleccionada |
| F / G | encuadrar / rejilla |
| Ctrl+Z / Ctrl+Y | deshacer / rehacer |

Las piezas se colocan con el cursor en su fila de abajo, para que apoyen en el suelo.

**Preview de luces** oscurece el mapa y deja ver el radio de las bombillas encendidas (el radio es solo orientativo, el real se ajusta en Godot).

## Piezas (bloques, ancho × alto; 1 bloque = 11 px)

| Pieza | `type` | Tamaño |
|---|---|---|
| Suelo / pared | `tiles.solid` | 1×1, se pintan en tramos |
| Plataforma | `tiles.platform` | 1×1 |
| Caja grande | `box_big` | 2×2 |
| Caja pequeña | `box_small` | 2×1 |
| Bombilla | `light` | 1×1 (`on`) |
| Puerta | `door` | 2×5 por defecto (`w`, `h`, `open`) |
| Base de arma / objeto | `weapon_base` | 2×1 (`item` opcional) |
| Spawn de jugador | `spawn` | 1×2 |

## Formato JSON (versión 1)

```json
{
  "version": 1,
  "name": "ejemplo",
  "grid": {"w": 96, "h": 54, "block_px": 11},
  "tiles": {
    "solid":    [{"x": 0, "y": 50, "w": 96, "h": 4}],
    "platform": [{"x": 12, "y": 40, "w": 12, "h": 1}]
  },
  "entities": [
    {"type": "spawn", "x": 8, "y": 48},
    {"type": "door", "x": 48, "y": 45, "w": 2, "h": 5, "open": false},
    {"type": "light", "x": 20, "y": 4, "on": true}
  ]
}
```

- Todo va en bloques, no en píxeles. `x`,`y` es la esquina superior izquierda y el eje Y crece hacia abajo (como en Godot).
- El tamaño de las piezas fijas lo conoce el loader por su `type`; solo la puerta lleva `w`/`h`.
- Si cambia el formato, se sube `version` y el editor y el juego migran los mapas viejos.
- El JSON solo lleva datos, nunca scripts.

## Pendiente

- Validación (pasillos, alturas, spawns): hay un hueco en `validate()`, apagado con `VALIDATE_ENABLED`.
- Botón "Guardar en repo" por la API de GitHub.
- `MapLoader` en Godot.
