# Grrrrnel

This is my bootloader project ,  built for 16-bit Real Mode x86 systems.

The main objective?
To understand how systems were implemented back in the day before fancy abstractions and layered APIs so I can truly grasp what’s changed and how things work under the hood today. It's about digging through history to become future-proof.

🚀 What It Does (So Far)

    ✅ Cleanly sets up segment registers (DS, ES, SS, SP)

    ✅ Loads additional sectors from disk using BIOS int 13h

    ✅ Reads data from disk and displays it using BIOS int 10h

    ✅ Fills the rest of the 512-byte boot sector with zeroes

    ✅ Safely avoids overwriting the BIOS Parameter Block (BPB)

🧪 Avoiding BPB Overwrite

BIOS often expects a BPB (BIOS Parameter Block) structure between bytes 3 and 36 of the boot sector.This way, any BIOS relying on BPB won't misbehave while we do our thing.

🗃️ File Structure
.
├── boot.asm        ; The bootloader source code
├── exp.txt         ; Additional sector with custom message/data
├── boot.bin        ; Final bootable image (512+ bytes)
├── Makefile        ; For assembling and appending sector data

🛠️ Build & Run

Assemble, attach the extra sector, and boot with QEMU:
make all
qemu-system-i386 -hda boot.bin


🎯 Goals Going Forward

Switch to Protected Mode

Start executing C code

Begin working on a proper kernel (heap, paging, drivers, etc.)

## This project is more of a bare-metal playground than a finished OS
