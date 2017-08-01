@0xd7b1fdae7f8daa87;

# Both task and data object id share the same numbering space and must use distinct ids.
# Session id is assigned by the server. Objects from different sessions may not interact.
# Session id <0 has a special meaning.
# Task id and data object id are the same struct but are distinct types for type checking.

struct TaskId {
    id @0 :Int32;
    sessionId @1 :Int32;

    const none :TaskId = ( sessionId = -1, id = 0 );
}

struct DataObjectId {
    id @0 :Int32;
    sessionId @1 :Int32;

    const none :DataObjectId = ( sessionId = -1, id = 0 );
}

struct PortAddress {
    # IPv4/6 address of a port.
    port @0 :UInt16;
    address :union {
        ipv4 @1: Data; # Network-endian address (4 bytes)
        ipv6 @2: Data; # Network-endian address (16 bytes)
    }
}

using WorkerId = PortAddress;
# Worker id is the address of the RPC listening port.

struct Additional {
    # Additonal data - stats, plugin data, user data, ...
    # TODO: Specify in an extensible way.
    # TODO: Consider embedding CBOR, MSGPACK, ... as Data.

    items @0 :List(Item);

    struct Item {
        key @0 :Text;
        value :union {
            int @1 :Int64;
            float @2 :Float64;
            text @3 :Text;
            data @4 :Data;
        }
    }
}