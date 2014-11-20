TODOs [lottes notes]: 

* figure out & check with henning what exactly the api (&rfc5444) optimizes and what needs to be specfied manually
* add packet sizes

----------------

**PLEASE NOTE:** this is obviously not supposed to go anywhere near the Draft.
I'm just sbmitting it here in order to track it properly. If anything comes out of this, I'll also add it to the XML properly.


In Honolulu, we talked about having some kind of visual representation of what we want our RFC5444 packets to look like. I promised to post the output of Henning's ``oonf api`` in order to show what I implemented. I think this may help to talk about what the RFC5444 packets should actually look like.

Here we go:  
I implemented what I called the “verbose version” in my review. Apparently that was wrong, but anyway-- here's what I came up with. (I disregarded prefixlengths entirely because of my scope limitation, though). The Sketches are basically what falls out of the oonf api when you call the ``rfc5444_print_direct()`` function of the oonf api.


RREQ
====
 
	,------------------
	|  PACKET
	|------------------
	| * Packet version:    0
	| * Packet flags:      0x0
	|    ,-------------------
	|    |  MESSAGE
	|    |-------------------
	|    | * Message type:       10
	|    | * Message flags:      0x40
	|    | * Address length:     16
	|    | * Hop limit:          18
	|    |    ,-------------------
	|    |    |  Address: fe80::ff:fe00:1fad
	|    |    |    | - TLV
	|    |    |    |     Flags = 0x50
	|    |    |    |     Type = 0
	|    |    |    |     Value length: 2
	|    |    |    |       0000: 0100
	|    |    |    | - TLV
	|    |    |    |     Flags = 0xd0
	|    |    |    |     Type = 3; Type ext. = 3
	|    |    |    |     Value length: 1
	|    |    |    |       0000: 02
	|    |    `-------------------
	|    |    ,-------------------
	|    |    |  Address: fe80::ff:fe00:1fa4
	|    |    `-------------------
	|    `-------------------
	`------------------


The OrigNode Address ``fe80::ff:fe00:1fad`` is associated with 2 TLVs:   
``OrigSeqNum_TLV``(Type = 0, identifying the Address as an OrigNode Address) and ``Metric_TLV`` (Type = 3). The Metric TLV also has an extension type to specify the Type of the Metric whose value is embedded in the TLV (in this case, ``DEFAULT_METRIC_TYPE``, which is 3).  
 If I understand the Draft correctly, it states that an additional TLV devoted to the Metric Type should be added, but this seemed like unnecessary overhead, since an entire TLV needs more bytes than an extension type, so I intentionally violated the spec there. I believe there are some more detailed E-Mails I exchanged with Charlie about this. (TODO: dig them up?)
 
Iirc, the draft states that TargNode Addresses of a RREQ do not need to be associated with any TLV at all, so my parser just assumes that an Address in a Message of type ``RREQ`` without a TLV is a TargNode Address. This made Henning cringe, I think.

TODO: maybe having a dedicated metric type TLV makes sense when we're talking multivalue TLVs? -> Depends on otimization TODO

RREP
====

	,------------------
	|  PACKET
	|------------------
	| * Packet version:    0
	| * Packet flags:      0x0
	|    ,-------------------
	|    |  MESSAGE
	|    |-------------------
	|    | * Message type:       11
	|    | * Message flags:      0x40
	|    | * Address length:     16
	|    | * Hop limit:          20
	|    |    ,-------------------
	|    |    |  Address: fe80::ff:fe00:1fad
	|    |    |    | - TLV
	|    |    |    |     Flags = 0x50
	|    |    |    |     Type = 0
	|    |    |    |     Value length: 2
	|    |    |    |       0000: 0100
	|    |    `-------------------
	|    |    ,-------------------
	|    |    |  Address: fe80::ff:fe00:1fa4
	|    |    |    | - TLV
	|    |    |    |     Flags = 0x50
	|    |    |    |     Type = 1
	|    |    |    |     Value length: 2
	|    |    |    |       0000: 0100
	|    |    |    | - TLV
	|    |    |    |     Flags = 0xd0
	|    |    |    |     Type = 3; Type ext. = 3
	|    |    |    |     Value length: 1
	|    |    |    |       0000: 01
	|    |    `-------------------
	|    `-------------------
	`------------------

``fe80::ff:fe00:1fad`` is associated with a ``OrigSeqNum_TLV``(Type = 0, identifying the Address as an OrigNode Address).  
``fe80::ff:fe00:1fa4`` is associated with both a TLV of type ``TargSeqNum_TLV`` (Type = 1, identifying the Address as an TargNode Address) as well as a TLV of type ``Metric_TLV`` (Type = 3), again with an extension type as described above.


RERR
====

TODO