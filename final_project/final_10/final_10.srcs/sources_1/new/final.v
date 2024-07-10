module dodge_game (
    input [1:0] btn,      // ���s��J
    input clk,            // ������J
    //input rst, 
    output reg [13:0] ar, // ���ܻP�C��ܦX��
    output reg [2:0] led  // LED ��ܥͩR�ƶq
);

reg [7:0] row;
reg [5:0] col;

// ��Y�ӱ��󺡨��ɸT�μҲ�


always @(*) begin
    ar[13:8] = col;
    ar[7:0] = row;
end
reg rst ;
reg [25:0] counter_300ms;   // 26-bit counter to control 300ms timing
reg [16:0] counter_1ms;     // Counter for 1ms timing
reg pulse_300ms;            // 300 ms pulse
reg pulse_1ms;              // 1 ms pulse
reg pulse_1ms_sync;         // Synchronized 1 ms pulse
reg pulse_1ms_flag;         // One-shot flag for 1 ms pulse
reg pulse_300ms_sync;       // Synchronized 300 ms pulse
reg pulse_300ms_flag;       // One-shot flag for 300 ms pulse
reg [5:0] player_pos;       // ���a��m (���)
reg [15:0] lfsr = 16'hfeac;
reg [5:0] drop[7:0];        // ������ (8��)

// State parameters
reg gamestate = 1;
parameter INIT = 3'b000;
parameter LIFE3 = 3'b111;
parameter LIFE2 = 3'b011;
parameter LIFE1 = 3'b001;
parameter CHEAT = 3'b010;
parameter DEAD = 3'b000;

reg [2:0] state_reg, state_next;


// ��l��
initial begin
    gamestate = 1;
    rst <= 0;
    player_pos = 6'b000100; // ���a��l��m�b�橳������
    drop[0] = 6'b000000; // ��l�Ʊ�����
    drop[1] = 6'b000000;
    drop[2] = 6'b000000;
    drop[3] = 6'b000000;
    drop[4] = 6'b000000;
    drop[5] = 6'b000000;
    drop[6] = 6'b000000;
    drop[7] = 6'b000000;
    counter_300ms = 0;
    counter_1ms = 0;
    pulse_300ms = 0;
    pulse_1ms = 0;
    pulse_1ms_sync = 0;
    pulse_1ms_flag = 0;
    pulse_300ms_sync = 0;
    pulse_300ms_flag = 0;
    state_reg = LIFE3;
end

always @(posedge rst) begin
    gamestate <= 1;
end

// 300�@��H���ͦ�
always @(posedge clk) begin
    if (counter_300ms < 17500000 - 1) begin
        counter_300ms <= counter_300ms + 1;
    end else begin
        counter_300ms <= 0;
        pulse_300ms <= ~pulse_300ms;  // �C300�@��½��@��
    end
end

// 1 �@��H���ͦ�
always @(posedge clk) begin
    if (counter_1ms < 85000 - 1) begin  // 125MHz�����U��1ms
        counter_1ms <= counter_1ms + 1;
    end else begin
        counter_1ms <= 0;
        pulse_1ms <= ~pulse_1ms;  // �C 1 �@��½��@��
    end
end

// 1ms�H���P�B
always @(posedge clk) begin
    pulse_1ms_sync <= pulse_1ms;
    pulse_1ms_flag <= (pulse_1ms_sync != pulse_1ms);
end

// 300ms�H���P�B
always @(posedge clk) begin
    pulse_300ms_sync <= pulse_300ms;
    pulse_300ms_flag <= (pulse_300ms_sync != pulse_300ms);
end

// �H���ͦ�������
wire feedback = lfsr[2] ^ lfsr[1];

always @(posedge pulse_300ms) begin
    lfsr <= {lfsr[14:0], lfsr[15]^lfsr[0]};
end

// ���������ʻP�ͦ�
always @(posedge pulse_300ms) begin
    // ���ʱ�����
    if (gamestate) begin
    drop[6] <= drop[5];
    drop[5] <= drop[4];
    drop[4] <= drop[3];
    drop[3] <= drop[2];
    drop[2] <= drop[1];
    drop[1] <= drop[0];
    // �H���ͦ��������b�̳���
    drop[0] <= 6'b0000001 << lfsr[2:0]; // �ϥ�LFSR�ͦ��H���C
end
end
// ���a����
always @(posedge clk) begin
    if (gamestate) begin
    if (state_reg==INIT)begin 
    player_pos = 6'b000100; // ���a��l��m�b�橳������
    end
    else if (btn0_pressed) begin
        if (player_pos != 6'b000001) begin
            player_pos <= (player_pos >> 1'b1);
        end
    end else if (btn1_pressed) begin
        if (player_pos != 6'b100000) begin
            player_pos <= (player_pos << 1'b1);
        end
    end
end
end
reg [1:0] btn_reg;
reg [1:0] btn_reg_next;

// ����ݰ�
always @(posedge clk) begin
    btn_reg <= btn;
    btn_reg_next <= btn_reg;
end

wire btn0_pressed = (btn_reg[0] && ~btn_reg_next[0]);
wire btn1_pressed = (btn_reg[1] && ~btn_reg_next[1]);

// �ͩR���A��
always @(posedge clk) begin
    if (gamestate && pulse_300ms_flag ) begin
        state_reg <= state_next;
    end
end



always @(posedge pulse_300ms) begin
if(gamestate)begin
    case (state_reg)
        INIT: begin
            led = DEAD; 
            if(drop[6] == player_pos) begin
                state_next = CHEAT;
            end else begin
                state_next = LIFE3;
            end
        end
        CHEAT: begin
            led = LIFE3; // �T���R
            if (drop[6] == player_pos) begin
                state_next = LIFE2;
            end else begin
                state_next = LIFE3;
            end
        end
        LIFE3: begin
            led = LIFE3; // �T���R
            if (drop[6] == player_pos) begin
                state_next = LIFE2;
            end else begin
                state_next = LIFE3;
            end
        end
        LIFE2: begin
            led = LIFE2; // ����R
            if (drop[6] == player_pos)begin
                state_next = LIFE1;
            end else begin
                state_next = LIFE2;
            end
        end
        LIFE1: begin
            led = LIFE1; // �@���R
            if (drop[6] == player_pos) begin
                state_next = INIT;
            end else begin
                state_next = LIFE1;
            end
        end
        default: state_next = INIT;
    endcase
    end
    
end


// ���y���
reg [2:0] scan_counter;  // ���y�p�ƾ�

always @(posedge clk) begin
    if (pulse_1ms_flag && gamestate) begin
        scan_counter <= scan_counter + 1;
    end
end

always @(posedge clk) begin
    if (pulse_1ms_flag && gamestate) begin
        case (scan_counter)
            3'd0: row = 8'b01111111;
            3'd1: row = 8'b10111111;
            3'd2: row = 8'b11011111;
            3'd3: row = 8'b11101111;
            3'd4: row = 8'b11110111;
            3'd5: row = 8'b11111011;
            3'd6: row = 8'b11111101;
            3'd7: row = 8'b11111110;
        endcase
    end
end

always @(posedge clk) begin
    if (pulse_1ms_flag && gamestate) begin
        case (scan_counter)
            3'd0: col = drop[0];
            3'd1: col = drop[1];
            3'd2: col = drop[2];
            3'd3: col = drop[3];
            3'd4: col = drop[4];
            3'd5: col = drop[5];
            3'd6: col = drop[6];
            3'd7: col = drop[7] | player_pos;
        endcase
    end
end

endmodule