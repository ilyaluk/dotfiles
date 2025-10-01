#include "sketchybar.h"
#include <CoreFoundation/CFDate.h>
#include <CoreFoundation/CoreFoundation.h>
#include <time.h>

void callback(CFRunLoopTimerRef timer, void *info) {
  time_t current_time;
  time(&current_time);

  char buffer[64];
  strftime(buffer, sizeof(buffer), "%H:%M", localtime(&current_time));

  char date_buffer[64];
  strftime(date_buffer, sizeof(date_buffer), "%a %-d %b",
           localtime(&current_time));

  uint32_t message_size = sizeof(buffer) + sizeof(date_buffer) + 64;
  char message[message_size];
  snprintf(message, message_size, "--set clock label=\"%s\" icon=\"%s\"",
           buffer, date_buffer);

  sketchybar(message);
}

int main() {
  // init first clock value
  callback(NULL, NULL);

  // call every second to better handle wakes from sleep etc
  // will be called at every second boundry
  CFAbsoluteTime current_time = CFAbsoluteTimeGetCurrent();
  CFRunLoopTimerRef timer =
      CFRunLoopTimerCreate(kCFAllocatorDefault, (int64_t)current_time + 1.0,
                           1.0, 0, 0, callback, NULL);
  CFRunLoopAddTimer(CFRunLoopGetMain(), timer, kCFRunLoopDefaultMode);
  CFRunLoopRun();
  return 0;
}
