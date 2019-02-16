#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <algorithm>

using namespace std;

double const PI = atan(1.0) * 4;
int const GRID_SIZE = 50;
int const radius = 20;

class Grid {
    public:
        Grid(int gridSize) {
            m_gridSize = gridSize;
            m_grid = new char*[m_gridSize * 2 + 1];
            for (int i = 0; i < m_gridSize * 2 + 1; i++)
                m_grid[i] = new char[m_gridSize * 2 + 1];
            clear();
        }
        // not tested
        Grid(Grid &grid) : Grid(grid.m_gridSize) {
            for (int i = -m_gridSize; i <= m_gridSize; i++)
                for (int j = -m_gridSize; j <= m_gridSize; j++)
                    paint(i, j, grid.get(i, j));
        }
        // not tested
        Grid& operator=(Grid &grid) {
            m_gridSize = grid.m_gridSize;
            m_grid = new char*[m_gridSize * 2 + 1];
            for (int i = 0; i < m_gridSize * 2 + 1; i++)
                m_grid[i] = new char[m_gridSize * 2 + 1];
            for (int i = -m_gridSize; i <= m_gridSize; i++)
                for (int j = -m_gridSize; j <= m_gridSize; j++)
                    paint(i, j, grid.get(i, j));
            return *this;
        }
        ~Grid() {
            for (int i = 0; i < m_gridSize; i++)
                delete m_grid[i];
            delete m_grid;
        }
        void clear() {
            for (int i = -m_gridSize; i <= m_gridSize; i++)
                for (int j = -m_gridSize; j <= m_gridSize; j++)
                    paint(i, j, ' ');
            for (int y = -m_gridSize; y <= m_gridSize; y++)
                paint(0, y, '|');
            for (int x = -m_gridSize; x <= m_gridSize; x++)
                paint(x, 0, '-');
            paint(0, 0, 'O');
            paint(0, m_gridSize, '^');
            paint(m_gridSize, 0, '>');
        }
        void paint(int x, int y, char color) {
            x += m_gridSize;
            y = m_gridSize - y;
            m_grid[x][y] = color;
        }
        char get(int x, int y) {
            x += m_gridSize;
            y = m_gridSize - y;
            return m_grid[x][y];
        }
        void print() {
            for (int y = radius; y >= -radius; y--) {
                for (int x = -m_gridSize; x <= m_gridSize; x++)
                    printf("%c", get(x, y));
                printf("\n");
            }
        }
    private:
        char **m_grid = nullptr;
        int m_gridSize = 0;
};

int main(int argc, char **argv) {
    printf("Argc: %d\n", argc);
    for (int i = 0; i < argc; i++)
        printf("Argv[%d]: %s\n", i, argv[i]);
    if (argc != 3) {
        printf("Usage:\n");
        printf("StarDrawing.exe <num_of_vertices> <draw_step>\n");
        return 0;
    }
    int vertices = atoi(argv[1]);
    int stepSize = atoi(argv[2]);
    printf("Vertices: %d\n", vertices);
    printf("StepSize: %d\n", stepSize);
    Grid grid(GRID_SIZE);
    for (int i = 0; i < vertices; i++) {
        for (int t = 0; t < vertices; t++) {
            int k = i + stepSize * t;
            int x = round(radius * cos(2 * PI * k / vertices + PI / 2));
            int y = round(radius * sin(2 * PI * k / vertices + PI / 2));
            grid.paint(x, y, '*');
            int k1 = i + stepSize * (t + 1);
            int x1 = round(radius * cos(2 * PI * k1 / vertices + PI / 2));
            int y1 = round(radius * sin(2 * PI * k1 / vertices + PI / 2));
            double dx = double(x1 - x) / 100.0;
            double dy = double(y1 - y) / 100.0;
            double cx = x;
            double cy = y;
            while (abs(cx - x1) > 1e-2 || abs(cy - y1) > 1e-2) {
                cx += dx;
                cy += dy;
                grid.paint(round(cx), round(cy), '*');
            }
        }
    }
    grid.print();
    return 0;
}
