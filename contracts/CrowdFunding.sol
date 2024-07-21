// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }

    // Each key maps to a Campaign object, public keyword makes the mapping accessible from outside the contract
    // 'campaigns' is the name of the mapping. It will store the Campaign objects, each associated with a unique uint256 key.
    mapping(uint256 => Campaign) public campaigns;

    // Defines a publicly accessible counter initialized to 0, which will be used to keep track of the number of campaigns.
    uint256 public numberOfCampaigns = 0;

    // In practice, when you create a new campaign, you will increment numberOfCampaigns and use it as the key in the campaigns mapping to store the new Campaign object. This way, each campaign can be uniquely identified and accessed using its key.


    // Variables in 'memory' are temporary and only exist for the duration of the function call. The 'storage' keyword is used for variables that are stored on the blockchain. 
    // 
    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image) public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns];

        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future.");

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        // After storing the new campaign, numberOfCampaigns is incremented to reflect the creation of a new campaign.
        numberOfCampaigns++;

        // numberOfCampaigns has been incremented after storing the campaign, so the actual index of the new campaign is numberOfCampaigns - 1.
        return numberOfCampaigns - 1;
    }

    // payable, meaning it can receive Ether

    // The function performs the following steps:
    //     Receives a donation in Ether.
    //     Retrieves the specified campaign using _id.
    //     Records the donor's address and the donation amount.
    //     Transfers the donation amount to the campaign owner.
    //     If the transfer is successful, updates the total amount collected for the campaign.
    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        // This line sends the 'amount' of Ether to the 'campaign.owner'. The 'payable' keyword allows an address to receive Ether, and '.call{value: amount}("")' sends the Ether. 
        // The result of this call is a boolean 'sent', which indicates whether the transfer was successful.
        (bool sent,) = payable(campaign.owner).call{value: amount}("");

        if(sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }


    function getDonators(uint256 _id) view public returns (address[] memory, uint256[] memory) {
        // Return the donators' addresses and their corresponding donation amounts for the campaign with ID _id
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    function getCampaigns() public view returns (Campaign[] memory) {
        // Initialize an array to hold all the campaigns, with the size equal to the number of campaigns
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);
        
        // Loop through all campaigns to populate the allCampaigns array
        for(uint i = 0; i < numberOfCampaigns; i++) {
            Campaign storage item = campaigns[i];
            allCampaigns[i] = item;
        }

        return allCampaigns;
    }

}