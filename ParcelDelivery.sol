pragma solidity ^0.5.2;

contract ParcelDelivery {
    address owner;
    uint num_parcels;

    struct Parcel {
      uint user_id;
      uint reciver_user_id;
      string to;
      string from_loc;
      uint price;
      string status;
      string description;
      bool doesExist;
    }

    mapping (uint => Parcel) parcels;

    event ParcelCreated(uint parcel_id);

    constructor() public {
        owner = msg.sender;
    }

    function createParcel(uint id_, uint user_id_, uint reciver_user_id_,
                          string memory to_, string memory from_,
                          uint price_, string memory status_,
                          string memory description_) public {
        num_parcels++;
        parcels[id_] = Parcel(user_id_,reciver_user_id_, to_, from_, price_, status_, description_, true);
        emit ParcelCreated(id_);

    }

    function isParcel(uint parcel_id) public view returns(bool isIndeed) {
        return parcels[parcel_id].doesExist;
    }

    function getNumOfParcels() public view returns(uint) {
        return num_parcels;
    }

    function getParcel(uint parcel_id) public view returns (uint,uint, uint,string memory,string  memory,uint,string  memory,string  memory) {
        require(isParcel(parcel_id), "Parcel must exist");
        Parcel memory p = parcels[parcel_id];
        return (parcel_id,
                p.user_id,
                p.reciver_user_id,
                p.to,
                p.from_loc,
                p.price,
                p.status,
                p.description);
    }

    function changeParcelState(uint parcel_id, string  memory status_) public {
        require(isParcel(parcel_id), "Parcel must exist");
        parcels[parcel_id].status = status_;
    }
    function editParcel(uint parcel_id, string memory  to_, string memory   from_,
                          uint price_, string memory   status_,
                          string memory  description_) public {
        require(isParcel(parcel_id), "Parcel must exist");
        parcels[parcel_id].status = status_;
        parcels[parcel_id].to = to_;
        parcels[parcel_id].from_loc = from_;
        parcels[parcel_id].price = price_;
        parcels[parcel_id].description = description_;
    }
}
