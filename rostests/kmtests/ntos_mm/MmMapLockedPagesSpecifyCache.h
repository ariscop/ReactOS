/*
 * PROJECT:         ReactOS kernel-mode tests
 * LICENSE:         GPLv2+ - See COPYING in the top level directory
 * PURPOSE:         Kernel-Mode Test Suite MmMapLockedPagesSpecifyCache test declarations
 * PROGRAMMER:      Pierre Schweitzer <pierre@reactos.org>
 */

 
#ifndef _KMTEST_MMMAPLOCKEDPAGESSPECIFYCACHE_H_
#define _KMTEST_MMMAPLOCKEDPAGESSPECIFYCACHE_H_

typedef struct _QUERY_BUFFER
{
    USHORT Length;
    PVOID Buffer;
    BOOLEAN Cached;
} QUERY_BUFFER, *PQUERY_BUFFER;

typedef struct _READ_BUFFER
{
    USHORT Length;
    PVOID Buffer;
    USHORT Pattern;
} READ_BUFFER, *PREAD_BUFFER;

#define IOCTL_QUERY_BUFFER 1
#define IOCTL_READ_BUFFER  2

#endif /* !defined _KMTEST_MMMAPLOCKEDPAGESSPECIFYCACHE_H_ */