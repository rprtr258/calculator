#include <unistd.h>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <algorithm>
#include <vector>

using namespace std;

double const PI = atan(1.0) * 4;
int const GRID_SIZE = 50;
int const radius = 20;

struct Point {
    double x = 0;
    double y = 0;
    double z = 0;
};

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
        void drawPolygon(const vector<Point> &points) {
            for (int i = 0; i < points.size(); i++) {
                paint(points[i].x, points[i].y, '*');
                line(points[i].x, points[i].y, points[(i + 1) % points.size()].x, points[(i + 1) % points.size()].y, '*');
            }
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
        // not tested
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


Point apply(Point p, vector<vector<double>> matrix) {
    Point res;
    res.x = p.x * matrix[0][0] + p.y * matrix[0][1] + p.z * matrix[0][2];
    res.y = p.x * matrix[1][0] + p.y * matrix[1][1] + p.z * matrix[1][2];
    res.z = p.x * matrix[2][0] + p.y * matrix[2][1] + p.z * matrix[2][2];
    return res;
}

int main(int argc, char **argv) {
    if (argc != 3) {
        printf("Usage: StarDrawing.exe <num_of_vertices> <draw_step>\n");
        printf("<draw_step> must be in range (0..<num_of_vertices> / 2)\n");
        return 0;
    }
    int vertices = atoi(argv[1]);
    int step = atoi(argv[2]);
    if (vertices <= 0) {
        printf("Incorrect vertices value\n");
        return 0;
    }
    if (step < 0 || step > vertices / 2) {
        printf("Incorrect step value\n");
        return 0;
    }
    Grid grid(GRID_SIZE);
    bool rotAroundZOrY = false;
    double rotateSpeed = 0.05;
    vector<Point> poly;
    for (int i = 0; i < vertices; i++) {
        for (int t = 0; t < vertices; t++) {
            int k = i + step * t;
            double x = round(radius * cos(2 * PI * k / vertices + PI / 2));
            double y = round(radius * sin(2 * PI * k / vertices + PI / 2));
            Point p = {x, y, 0};
            poly.push_back(p);
        }
    }
    printf("\x1B[?25l"); // hide cursor
    while (true) {
        if (rotAroundZOrY) {
            for (Point &p : poly)
                p = apply(p, {{cos(rotateSpeed), -sin(rotateSpeed), 0}, {sin(rotateSpeed), cos(rotateSpeed), 0}, {0, 0, 1}}); // Z X
        } else {
            for (Point &p : poly) {
                p = apply(p, {{cos(rotateSpeed), 0, -sin(rotateSpeed)}, {0, 1, 0}, {sin(rotateSpeed), 0, cos(rotateSpeed)}}); // Y
                p = apply(p, {{cos(rotateSpeed), -sin(rotateSpeed), 0}, {sin(rotateSpeed), cos(rotateSpeed), 0}, {0, 0, 1}}); // Z
                //p = apply(p, {{1, 0, 0}, {0, cos(rotateSpeed), -sin(rotateSpeed)}, {0, sin(rotateSpeed), cos(rotateSpeed)}}); // X
            }
        }
        grid.drawPolygon(poly);
        grid.print();
        grid.clear();
        for (int i = 0; i < radius * 2 + 1; i++)
            printf("\x1B[1A");
        usleep(40000);
    }
    return 0;
}
