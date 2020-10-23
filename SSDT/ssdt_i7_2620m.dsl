/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20110316-64 [Mar 16 2011]
 * Copyright (c) 2000 - 2011 Intel Corporation
 * 
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000036A (874)
 *     Revision         0x01
 *     Checksum         0x98
 *     OEM ID           "APPLE "
 *     OEM Table ID     "CpuPm"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20110316 (537985814)
 */

DefinitionBlock ("ssdt_i7_2620m.aml", "SSDT", 1, "APPLE ", "CpuPm", 0x00001000)
{
    External (\_PR_.CPU0, DeviceObj)
    External (\_PR_.CPU1, DeviceObj)
    External (\_PR_.CPU2, DeviceObj)
    External (\_PR_.CPU3, DeviceObj)

    Scope (\_PR.CPU0)
    {
        Method (APSN, 0, NotSerialized)
        {
            Return (0x07)
        }
        Method (APSS, 0, NotSerialized)
        {
            Return (Package (0x1B)
            {
                Package (0x06)
                {
                    3400,
                    0x000088B8,
                    0x0A,
                    0x0A,
                    0x2200,
                    0x2200
                },
                Package (0x06)
                {
                    3300,
                    0x000088B8,
                    0x0A,
                    0x0A,
                    0x2100,
                    0x2100
                },
                Package (0x06)
                {
                    3200,
                    0x000088B8,
                    0x0A,
                    0x0A,
                    0x2000,
                    0x2000
                },
                Package (0x06)
                {
                    3100,
                    0x000088B8,
                    0x0A,
                    0x0A,
                    0x1F00,
                    0x1F00
                },
                Package (0x06)
                {
                    3000,
                    0x000088B8,
                    0x0A,
                    0x0A,
                    0x1E00,
                    0x1E00
                },
                Package (0x06)
                {
                    2900,
                    0x000088B8,
                    0x0A,
                    0x0A,
                    0x1D00,
                    0x1D00
                },
                Package (0x06)
                {
                    2800,
                    0x000088B8,
                    0x0A,
                    0x0A,
                    0x1C00,
                    0x1C00
                },
                Package (0x06)
                {
                    2700,
                    0x000088B8,
                    0x0A,
                    0x0A,
                    0x1B00,
                    0x1B00
                },
                Package (0x06)
                {
                    2600,
                    0x00005F42,
                    0x0A,
                    0x0A,
                    0x1A00,
                    0x1A00
                },
                Package (0x06)
                {
                    2500,
                    0x00005A82,
                    0x0A,
                    0x0A,
                    0x1900,
                    0x1900
                },
                Package (0x06)
                {
                    2400,
                    0x000055DA,
                    0x0A,
                    0x0A,
                    0x1800,
                    0x1800
                },
                Package (0x06)
                {
                    2300,
                    0x00005149,
                    0x0A,
                    0x0A,
                    0x1700,
                    0x1700
                },
                Package (0x06)
                {
                    2200,
                    0x00004CD0,
                    0x0A,
                    0x0A,
                    0x1600,
                    0x1600
                },
                Package (0x06)
                {
                    2100,
                    0x0000486E,
                    0x0A,
                    0x0A,
                    0x1500,
                    0x1500
                },
                Package (0x06)
                {
                    2000,
                    0x00004423,
                    0x0A,
                    0x0A,
                    0x1400,
                    0x1400
                },
                Package (0x06)
                {
                    1900,
                    0x00003FEE,
                    0x0A,
                    0x0A,
                    0x1300,
                    0x1300
                },
                Package (0x06)
                {
                    1800,
                    0x00003BD1,
                    0x0A,
                    0x0A,
                    0x1200,
                    0x1200
                },
                Package (0x06)
                {
                    1700,
                    0x000037CA,
                    0x0A,
                    0x0A,
                    0x1100,
                    0x1100
                },
                Package (0x06)
                {
                    1600,
                    0x000033D9,
                    0x0A,
                    0x0A,
                    0x1000,
                    0x1000
                },
                Package (0x06)
                {
                    1500,
                    0x00002FFF,
                    0x0A,
                    0x0A,
                    0x0F00,
                    0x0F00
                },
                Package (0x06)
                {
                    1400,
                    0x00002C3A,
                    0x0A,
                    0x0A,
                    0x0E00,
                    0x0E00
                },
                Package (0x06)
                {
                    1300,
                    0x0000288B,
                    0x0A,
                    0x0A,
                    0x0D00,
                    0x0D00
                },
                Package (0x06)
                {
                    1200,
                    0x000024F1,
                    0x0A,
                    0x0A,
                    0x0C00,
                    0x0C00
                },
                Package (0x06)
                {
                    1100,
                    0x0000216D,
                    0x0A,
                    0x0A,
                    0x0B00,
                    0x0B00
                },
                Package (0x06)
                {
                    1000,
                    0x00001DFE,
                    0x0A,
                    0x0A,
                    0x0A00,
                    0x0A00
                },
                Package (0x06)
                {
                    900,
                    0x00001AA3,
                    0x0A,
                    0x0A,
                    0x0900,
                    0x0900
                },
                Package (0x06)
                {
                    800,
                    0x0000175D,
                    0x0A,
                    0x0A,
                    0x0800,
                    0x0800
                }
            })
        }

        Method (ACST, 0, NotSerialized)
        {
            Return (Package (0x06)
            {
                One,
                0x04,
                Package (0x04)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW,
                            0x01,               // Bit Width
                            0x02,               // Bit Offset
                            0x0000000000000000, // Address
                            0x01,               // Access Size
                            )
                    },

                    One,
                    0x03,
                    0x03E8
                },

                Package (0x04)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW,
                            0x01,               // Bit Width
                            0x02,               // Bit Offset
                            0x0000000000000010, // Address
                            0x03,               // Access Size
                            )
                    },

                    0x03,
                    0xCD,
                    0x01F4
                },

                Package (0x04)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW,
                            0x01,               // Bit Width
                            0x02,               // Bit Offset
                            0x0000000000000020, // Address
                            0x03,               // Access Size
                            )
                    },

                    0x06,
                    0xF5,
                    0x015E
                },

                Package (0x04)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW,
                            0x01,               // Bit Width
                            0x02,               // Bit Offset
                            0x0000000000000030, // Address
                            0x03,               // Access Size
                            )
                    },

                    0x07,
                    0xF5,
                    0xC8
                }
            })
        }
    }

    Scope (\_PR.CPU1)
    {
        Method (APSN, 0, NotSerialized)
        {
            Return (\_PR.CPU0.APSN())
        }
        Method (APSS, 0, NotSerialized)
        {
            Return (\_PR.CPU0.APSS())
        }
        Method (ACST, 0, NotSerialized)
        {
            Return (\_PR.CPU0.ACST())
        }
    }

    Scope (\_PR.CPU2)
    {
        Method (APSN, 0, NotSerialized)
        {
            Return (\_PR.CPU0.APSN())
        }
        Method (APSS, 0, NotSerialized)
        {
            Return (\_PR.CPU0.APSS())
        }
        Method (ACST, 0, NotSerialized)
        {
            Return (\_PR.CPU0.ACST())
        }
    }

    Scope (\_PR.CPU3)
    {
        Method (APSN, 0, NotSerialized)
        {
            Return (\_PR.CPU0.APSN())
        }
        Method (APSS, 0, NotSerialized)
        {
            Return (\_PR.CPU0.APSS())
        }
        Method (ACST, 0, NotSerialized)
        {
            Return (\_PR.CPU0.ACST())
        }
    }
}
