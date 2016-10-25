'use strict';

//////////////////////////////////////////////////////////////////////////////
var EntityType = {
    GOOD: 0,
    EVIL: 1
};

function Entity(entityName, entityType, components=[]) {
    var self = this;
    this.entityName = entityName;
    this.components = [];
    components.forEach(function(component) {
        self.addComponent(component);
    });
    this.components = components;
    this.type = entityType;
}

Entity.prototype.addComponent = function(component) {
    this.components.push(component);
    component.entity = this;
};

Entity.prototype.tick = function() {
    var outcoming = [];
    this.components.forEach(function(component) {
        var messages = component.tick();
        messages.forEach(function (message) {
            outcoming.push(message);
        });
    });
    return outcoming;
};

Entity.prototype.receive = function(message) {
    if(!message.receiver || message.receiver === this) {
        this.components.forEach(function(component) {
            component.receive(message);
        });
    }
};
//////////////////////////////////////////////////////////////////////////////
// if the receiver is null, it is a broadcast message
function Message(receiver=null) {
    this.receiver = receiver;
}

//////////////////////////////////////////////////////////////////////////////
function Component(entity=null) {
    this.entity = entity;
    this.messageQueue = [];
}

Component.prototype.tick = function() {
    var aux = this.messageQueue;
    this.messageQueue = [];
    return aux;
};
Component.prototype.receive = function(message) {
};


//////////////////////////////////////////////////////////////////////////////

function Game(entities) {
    this.entities = entities;
    this.messageQueue = [];
}
Game.prototype.mainLoop = function (ticks=null) {
    var i = 0;
    while(!ticks || i < ticks) {
        this.tick();
        i++;
    }
};
Game.prototype.tick = function () {
    var self = this;

    this.entities.forEach(function(entity) {
        self.messageQueue.push(new Presence(entity));
    });

    this.entities.forEach(function(entity) {
        var tickMessages = entity.tick();

        tickMessages.forEach(function(tickMessage) {
            self.messageQueue.push(tickMessage);
        });
    });

    this.deliver();
};
Game.prototype.deliver = function() {
    var self = this;

    this.messageQueue.forEach(function(message) {
        if(!message.receiver) {         
            self.entities.forEach(function(entity) {
                entity.receive(message);
            });
        }
        else {
            message.receiver.receive(message);
        }
    });

    this.messageQueue = [];
};

//////////////////////////////////////////////////////////////////////////////
// Components
//////////////////////////////////////////////////////////////////////////////
function Attacker(entity=null) {
    Component.call(this, entity);
}
Attacker.prototype = Object.create(Component.prototype);
Attacker.prototype.constructor = Attacker;

Attacker.prototype.receive = function(message) {
    if(message instanceof Presence) {
        if(message.who.type != this.entity.type) {
            this.messageQueue.push(new Attack(message.who, this.entity));
        }
    }
};

//////////////////////////////////////////////////////////////////////////////
function Defender(entity=null) {
    Component.call(this, entity);
}
Defender.prototype = Object.create(Component.prototype);
Defender.prototype.constructor = Defender;

Defender.prototype.receive = function(message) {
    if(message instanceof Attack) {
        console.log(this.entity.entityName + " was attacked by " + message.who.entityName);
    }
};



//////////////////////////////////////////////////////////////////////////////
// Messages
//////////////////////////////////////////////////////////////////////////////
function Presence(who, receiver=null) {
    Message.call(this, receiver);
    this.who = who;
}
Presence.prototype = Object.create(Message.prototype);
Presence.prototype.constructor = Presence;
//////////////////////////////////////////////////////////////////////////////
function Attack(who, receiver=null) {
    Message.call(this, receiver);
    this.who = who;
}
Attack.prototype = Object.create(Message.prototype);
Attack.prototype.constructor = Attack;

//////////////////////////////////////////////////////////////////////////////



var attacker = function() { return new Attacker(); };
var defender = function() { return new Defender(); };
var player = new Entity("link", EntityType.GOOD, [attacker(), defender()]);
var enemy = new Entity("ganon", EntityType.EVIL, [attacker(), defender()]);
var game = new Game([player, enemy]);
game.mainLoop(10);

