import os
import glob
import re
import sys

guiPath = os.path.join("..", "_", "ui", "qml", "gui.qml")

if not os.path.exists(guiPath):
    print("gui.qml not found")
    sys.exit(1)

print("scanning images...")
image_extensions = ["*.png", "*.jpg", "*.jpeg", "*.gif", "*.bmp"]
images = []
for ext in image_extensions:
    images.extend(glob.glob(ext))

count = len(images)

if count == 0:
    print("no images found")
    sys.exit(0)

print(f"found {count} images")

try:
    with open(guiPath, 'r', encoding='utf-8') as f:
        content = f.read()
except IOError:
    print(f"error reading {guiPath}")
    sys.exit(1)

new_lines = []
for i, filename in enumerate(images):
    base_filename = os.path.basename(filename)
    
    line = f'\t\t\t"{base_filename}"'
    
    if i < count - 1:
        line += ","
    
    new_lines.append(line)

image_content = "\n".join(new_lines)

regex_pattern = r"(property\s+var\s+imageFiles\s*:\s*\[)\s*([\s\S]*?)\s*(\])"

if not re.search(regex_pattern, content, flags=re.DOTALL):
    print("failed to find 'imageFiles' property in gui.qml")
    sys.exit(1)

replacement = r"\1" + "\n" + image_content + "\n\t\t" + r"\3"

new_content = re.sub(regex_pattern, replacement, content, flags=re.DOTALL)

if new_content == content:
    print("no changes needed - gui.qml already contains the same images")
    sys.exit(0)

try:
    with open(guiPath, 'w', encoding='utf-8') as f:
        f.write(new_content)
except IOError:
    print(f"error writing to {guiPath}")
    sys.exit(1)

print(f"updated gui.qml with {count} images\npress Enter to close...")

input()