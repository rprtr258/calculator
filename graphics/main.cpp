#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <algorithm>
#include <unistd.h>

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
        void line(int x1, int y1, int x2, int y2, char color = '*') {
            double dx = double(x2 - x1) / 100.0;
            double dy = double(y2 - y1) / 100.0;
            double cx = x1;
            double cy = y1;
            while (abs(cx - x2) > 1e-2 || abs(cy - y2) > 1e-2) {
                cx += dx;
                cy += dy;
                paint(round(cx), round(cy), color);
            }
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

void drawStar(Grid &grid, int vertices, int step, double initAngle) {
    for (int i = 0; i < vertices; i++) {
        for (int t = 0; t < vertices; t++) {
            int k = i + step * t;
            int x = round(radius * cos(2 * PI * k / vertices + initAngle));
            int y = round(radius * sin(2 * PI * k / vertices + initAngle));
            grid.paint(x, y, '*');
            int k1 = i + step * (t + 1);
            int x1 = round(radius * cos(2 * PI * k1 / vertices + initAngle));
            int y1 = round(radius * sin(2 * PI * k1 / vertices + initAngle));
            grid.line(x, y, x1, y1, '*');
        }
    }
}

int main(int argc, char **argv) {
    printf("\x1B[?25l"); // hide cursor
    int vertices = atoi(argv[1]);
    int step = atoi(argv[2]);
    Grid grid(GRID_SIZE);
    double rotateSpeed = 0.05;
    double initAngle = PI / 2;
    while (true) {
        initAngle += rotateSpeed;
        drawStar(grid, vertices, step, initAngle);
        grid.print();
        grid.clear();
        for (int i = 0; i < radius * 2 + 1; i++)
            printf("\x1B[1A");
        usleep(40000);
    }
    return 0;
}
