# FlashMapMaker

Editor de mapas para el juego. Una sola página (`index.html`), sin build ni dependencias. Funciona en GitHub Pages.

**👉 https://xneku.github.io/FlashMapMaker/**

## Usarlo

- Online: el enlace de arriba.
- En local: abre `index.html` en el navegador.
- Activar Pages (una vez): Settings → Pages → Deploy from a branch → `main` / `(root)`.

El mapa se autoguarda en el navegador (`localStorage`) mientras editas.

## Guardar en el repo del juego

Los mapas viven en el **repo del juego**, no en este: `xNeku/godot-multiplayer-high-level`, rama `escala-y-mapas`, carpeta `maps/`. El botón **Guardar en repo** sube el mapa como `maps/<nombre>.json` (el nombre se sanea: letras, números, guion y guion bajo). Después de un `git pull` el juego lo ve solo en el selector del lobby, sin importar nada.

- Si el archivo ya existe pregunta antes de sobrescribirlo (la API de GitHub exige el `sha` del existente, el editor lo pide solo). Si está idéntico, no sube nada.
- **Token (una vez por navegador):** GitHub → Settings → Developer settings → Personal access tokens → Fine-grained tokens → Generate new token. *Repository access*: solo `godot-multiplayer-high-level`. *Permissions → Repository permissions → Contents*: **Read and write**. Se pega en ⚙. Se guarda solo en ese navegador (`localStorage`) y nunca se sube a ningún repo. El de lectura y el de escritura es el mismo.
- **⚙** también cambia repo, rama y carpeta (por ejemplo cuando `escala-y-mapas` se mezcle con `main`, o si se usa una rama `mapas` aparte). No hace falta tocar código.
- Avisa antes de guardar si el mapa se pasa de lo que el juego acepta al cargar: 512 KB de texto, rejilla 512×512, 5000 rectángulos (suelo + plataformas) y 2000 entidades. Con **Exportar JSON** también avisa.
- Sin token no se puede guardar. Si el repo del juego es privado, tampoco se pueden ver ni abrir los mapas: el token hace falta para todo.

**Mapas del repo** (cabecera) lista lo que hay en esa carpeta y rama, es decir, lo mismo que ve el juego. **Abrir copia** lo abre como `nombre_copia` para no pisar el original; **Descargar** baja una copia a tu PC.

**Exportar JSON** descarga el archivo sin tocar ningún repo (sirve para mandárselo a alguien).

## Controles

| | |
|---|---|
| Rueda | zoom |
| Click derecho / Espacio + arrastrar | mover la vista |
| Arrastrar (suelo/plataforma) | pintar bloques |
| Shift + arrastrar | borrar bloques |
| Ctrl + arrastrar | rellenar rectángulo |
| 1–9, 0 | herramientas |
| Seleccionar (1): click o arrastrar | marca piezas **y bloques**; Shift añade |
| Arrastrar lo marcado | lo mueve (bloques y piezas juntos) |
| Ctrl+C / Ctrl+X / Ctrl+V | copiar / cortar / pegar. Al pegar sale un sello: click para colocar (se puede repetir), Esc para salir |
| Ctrl+A | seleccionar todo |
| Flechas / Supr | mover / borrar lo marcado |
| L | encender/apagar las bombillas marcadas |
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
- Guardar sin cuenta de GitHub (para quien no tenga): haría falta un intermediario pequeño con contraseña compartida. De momento esa persona usa **Exportar JSON** y lo manda.
- El `MapLoader` vive en el repo del juego, no aquí.
