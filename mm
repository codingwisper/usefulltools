#include <windows.h>
#include <stdbool.h>

// Simulate a left mouse click
bool LeftClick()
{
    INPUT Inputs[2] = {0};

    Inputs[0].type = INPUT_MOUSE;
    Inputs[0].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;

    Inputs[1].type = INPUT_MOUSE;
    Inputs[1].mi.dwFlags = MOUSEEVENTF_LEFTUP;

    UINT result = SendInput(2, Inputs, sizeof(INPUT));
    return result == 2;
}

int main()
{
    POINT lastPos;
    if (!GetCursorPos(&lastPos)) {
        return 1;
    }
    
    bool moveToTopLeft = true;

    while (1)
    {
        Sleep(10 * 1000);  // Wait 10 seconds for testing

        POINT currentPos;
        if (!GetCursorPos(&currentPos)) {
            continue;
        }

        // Check if mouse position changed
        if (currentPos.x == lastPos.x && currentPos.y == lastPos.y)
        {
            int screenWidth  = GetSystemMetrics(SM_CXSCREEN);
            int screenHeight = GetSystemMetrics(SM_CYSCREEN);

            int targetX, targetY;
            if (moveToTopLeft)
            {
                targetX = 10;  // Move slightly inside to avoid edge issues
                targetY = 10;
            }
            else
            {
                targetX = screenWidth - 10;  // Move slightly inside to avoid edge issues
                targetY = screenHeight - 10;
            }

            if (SetCursorPos(targetX, targetY)) {
                LeftClick();
            }
            
            moveToTopLeft = !moveToTopLeft;  // Toggle direction
        }

        // Update last position
        lastPos = currentPos;
    }

    return 0;
}
