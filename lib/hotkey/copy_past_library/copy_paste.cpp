#define WINVER 0x0500
#include <windows.h>
 #pragma comment(lib, "User32.lib")
int main()
{
    // Create a generic keyboard event structure
    INPUT ip;
    ip.type = INPUT_KEYBOARD;
    ip.ki.wScan = 0;
    ip.ki.time = 0;
    ip.ki.dwExtraInfo = 0;
 
    while(true)
    {
        if (GetAsyncKeyState(VK_SPACE))
		{
        // Press the "Ctrl" key
        ip.ki.wVk = VK_CONTROL;
        ip.ki.dwFlags = 0; // 0 for key press
        SendInput(1, &ip, sizeof(INPUT));
 
        // Press the "V" key
        ip.ki.wVk = 'V';
        ip.ki.dwFlags = 0; // 0 for key press
        SendInput(1, &ip, sizeof(INPUT));
 
        // Release the "V" key
        ip.ki.wVk = 'V';
        ip.ki.dwFlags = KEYEVENTF_KEYUP;
        SendInput(1, &ip, sizeof(INPUT));
 
        // Release the "Ctrl" key
        ip.ki.wVk = VK_CONTROL;
        ip.ki.dwFlags = KEYEVENTF_KEYUP;
        SendInput(1, &ip, sizeof(INPUT));
         
        Sleep(100); // pause for 1 second
    }
    }
 
    // We won't actually ever reach this point
    return 0;
}