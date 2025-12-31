# Rune Entities Lab 🧪

## 🎯 Objetivo
Crear un sistema de entidades (jugador, aliados y enemigos) utilizando **únicamente herramientas nativas de Godot**. El fin es validar la jugabilidad y la "diversión" del combate táctico antes de producir arte final.

## 🛠 Filosofía: "Geometría con Propósito"
No usaremos sprites externos. Cada entidad se definirá por su forma, color y comportamiento visual generado por código.

### 👤 El Protagonista (The Caster)
*   **Representación:** Un `Polygon2D` con forma de **Hexágono Estilizado**.
*   **Identidad Visual:** 
    *   Color: Blanco puro o Cian brillante.
    *   Efecto: Un `Glow` generado con un Shader de aura.
    *   Feedback: Al lanzar un hechizo, el hexágono se expande y emite partículas.
*   **Componentes:** Brazo selector (un `Line2D` que apunta al mouse).

### 👹 Los Enemigos y Aliados (Monsters)
Las criaturas se clasificarán por "Tipo de Cuerpo" usando polígonos simples:

1.  **Tipo Tanque (Tierra/Roca):**
    *   Forma: **Cuadrado/Rombo** robusto.
    *   Movimiento: Lento, pesado.
2.  **Tipo Rápido (Viento/Agua):**
    *   Forma: **Triángulo** isósceles apuntando al frente.
    *   Movimiento: Ágil, rotación rápida.
3.  **Tipo Mágico (Fuego/Luz):**
    *   Forma: **Círculo** (generado por un Polygon2D de muchos lados o un Shader).
    *   Movimiento: Errático o estático.

### 🎨 Código de Colores Elementales
Usaremos la paleta de *Lost Magic* para identificar debilidades instantáneamente:
*   🔴 **Fuego:** Rojo intenso.
*   🔵 **Agua:** Azul cristalino.
*   🟢 **Viento:** Verde lima.
*   🟤 **Tierra:** Marrón/Naranja oscuro.
*   ⚪ **Luz:** Amarillo/Blanco.
*   🟣 **Oscuridad:** Violeta/Negro.

## ⚡ Visualización de Estado (UI In-World)
Todo debe ser visible en el "mundo" sin HUDs complejos:
*   **Vida:** Una barra circular (`TextureProgressBar` con un círculo simple) que rodea a la entidad.
*   **Daño:** El polígono "parpadea" en blanco y se deforma ligeramente (Tween de escala).
*   **Muerte:** El polígono se rompe en trozos (`CPUParticles2D` con forma de la misma entidad pero más pequeños).
*   **Selección:** Un círculo de `Line2D` giratorio debajo de los pies de la entidad.

## 🧪 Alcance del Laboratorio
1.  [ ] Crear script base `Entity.gd` con lógica de vida y elementos.
2.  [ ] Implementar `ProceduralVisuals.gd` para dibujar las formas por código.
3.  [ ] Sistema de "Selección RTS" para los aliados (Triángulos/Cuadrados).
4.  [ ] IA básica de persecución y ataque para los enemigos.
