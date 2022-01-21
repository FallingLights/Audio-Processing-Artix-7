// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Fri Jan 21 18:53:15 2022
// Host        : DESKTOP-UGHHMC4 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {d:/OneDrive - Univerza v
//               Ljubljani/3.letnik/dn/domaca_naloga/obdelava-zvoka/Seminarska.gen/sources_1/bd/bram/ip/bram_blk_mem_gen_0_0/bram_blk_mem_gen_0_0_sim_netlist.v}
// Design      : bram_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a50tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bram_blk_mem_gen_0_0,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2021.1" *) 
(* NotValidForBitStream *)
module bram_blk_mem_gen_0_0
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    rsta_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  output rsta_busy;

  wire [31:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire rsta;
  wire rsta_busy;
  wire [3:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.3746 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  bram_blk_mem_gen_0_0_blk_mem_gen_v8_4_4 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web({1'b0,1'b0,1'b0,1'b0}));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2021.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
sbNGmomEbP78s1hfxgX3P1Jo01EKJk0i0C7iGpF+Yibr9EK0s4mcIifHDN/ag4jpPwW3bPllMHvn
U8AEY3mO8hCXVVoilrcRuCaEna/98GycCzy4G7FnYMfowsJb5k9ifRdE2jnurzeTLFbupUSpDF0H
Rl3Ci3DTGeExAZZ9UQE=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
zZZZoIprBFYfDWmCCcduELBM7HU98/+rvP9g8+y1mYyD3r3HEDm4ZwehwZvPoYWqoGXYoFqWZh3h
utt0abIfUW9/oF2vJ9hXn7nArtcm/Eui18rPYqp3aj/AItPNVXojk9zp7uFZLPTqcyig5v3Jtenl
qPnLi1Z84ZCW7NIRw6Y0bgmw6z26E8VPbYrZHs+0YW8Sztjo6CdIrQeEL5WBDolA0aHoKHWRZyFs
l5eRDmBAolj2uF07t/3eY3J7cYJmEDaoZ0TR1qcz25VFNu0OlcrEJ19IT+QdAxTah4jqJtknGZrT
6lUMwDZ7dBQwF1EuaE6p90gGNERhGAsbHLdvaw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
KUbz0Iu2faeWqD6HFeuGLtSOAlqZmpKCCJfzym8tkcWUUNgNMn2mYvx6PTM7j4tyig8JdUG3uZYs
NfPgAsNXQtTI7b19u9CkMks9jR+oEzX1rW7QtTvSj/nHZLg2smoFwuB5Ieb7/B8IIs1NTUrIz6Rc
itLQVG+L+GMziamsrx4=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
G7XYdRx9VGclyxTEtwMG+rjJHV8bfBxEGdkcN82UL3koN3Dt0M5AWkzEvHcskt1W0hTOjyYgmvYj
/p70w1nz96tlg226+e4UubpRmBH9QXBBX6UmqIwSiHj9H+XI1yNfTIdlwBKGQvfzwCAMwBwrrrGL
/804k5Ux3RhWRvwezZB4+sj9DFm4akREVXmNpfeqjI2X02LU/MxWMUbKxvjJnD9YxikAAO6ccTd6
8DKv76V76MEFVyXc7E2FeQDToW3lqkRTa6MTpIXbYSekRihQC+qPVuhPUneA4kepvQDfgFYE8/Ir
gu5gK+s/qNfuXhJUAqyLjslrUcY4+XD9ckpSvQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YXkYRXpUPv/tETnwnThdQ46UaPmI23lN9vrxHQjIOhq3WNJCuz7TYZK9hyzSdo6k0U6QE9ihQy2L
rYZg68RGbrK8bzlcnQ41r18LZb4GYlAn9PH7IrF1B+aHm3578doOZHf8wzUE2s+d1aHQIn6VIZjL
14pCTAjErJfMO13fgX6h8sgxb4GFC3eIORmkrq2J/fB9HALyh/qdGiLi7DejMfmdsssbOcPQTZUh
6Belf7fHTkIEr9B44rFZgMyrMVx4N9p0XpXD3JPe7Xeg6a3jxdqxHATaMuLdIa4s+ZiAz1TRx0EO
FFihCnLLb7weBBITQyTIncRL817BrF/ZXZD8Yw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_01", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
g7FbNw1ywd4TBNHq8OmK/4zoKI/t7vKmyT8R8SeiyUtKywhn0/7DZ/lV0Lf4IhY8X5MYsKtOQ5l6
DIl3fxtOhxpi8NHn9Nw3Nfb8NnS38Zuy6DSpwOL0f/GSmUSf2/YdB5Ben6xibQT0Oy//oBl5/1kR
pV5fWjj8WRgI6cnmfyj3g1MxepxPu1A/UHxlm1/i9yUHHi114N/hEQ0iujjrn6GxfZSiJUVF+r6c
rnxD//eOAl/YaxhdU/KhUkfsMn+MxtA5m6hTYYE0bnze8rpmEU5UGYKyY0p8KUs+MgsdTe+m/7gV
HSf6puBqQmEa1qksRfl742aL9B9y169or7Jp9Q==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kd1A2zIphLxXB0RyfHIqLkHXfWl0n38vROERuDghYrhK0ItcWGEP0XBrri6k1VZCSPYwiSu//pM6
83BfcPKbk09/A+ksvDIa3xS8Tg7DJK2AS+0pdnzBSjVWh+QD+glA3Hjk6LG9OMbjXyqD3hnMKacA
VRMwxKktV+KT5NXj5a7fMxXjo9exc0xM+woUJiSYs8onoUSwfBeH5/xhUy+iu+w0/OOydQE2LXZ0
1y+RObiz5C22dD4GGCfuvUCGAthYpUf633ZxRYN45mmAn5PxPsH4o+l2GhH/50Gu/VPVoAWDhgXQ
e93oPri++HinkK2uvDhDl4PI9HtRkq11Ky3uXQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
gDrrFgXHVyBo+Cn0bYn+SOSOCXPg7besukY6l0JmA/nu4gap105Wxbg11c7TJZ9ctHVLc5DXAxr+
EIvFpAIepoZBREtMjTlaIdNJ8k1nUpwAv2jaQeseq1TudTjugV1jtOYYk0RKd88z/6SJ8t9urDW0
yKqsfEWU3PwGcUGHOWtTn2hfAceNznmEIFWLmFmzSQJ1hQNdsIQn3jHnfMVYu8cAz5xvPVQWYyJW
pMHXhNYk6GyAjIshh991slb1g01K1ilR2tKD1EmxH5WGrX9BEUqBjHQo6uluC/d3mvcEQ5nJ1v+P
hIlj4qzUQT1wXjpk6d/BvNx7LyWmj5iq35dzNm+cdhfGwaFGG//vgmB6D/dFfs2BYSjHsa6VlpVM
7e2OgoFenuG9p1SVPI6gAs2MuFtnDKfxW7jS3RGhvsquS3tg1iFCDH/OU7E5aWfY7twF3yyN6G10
l72RZw62DfNoCdyUMG9sA8nc4qf6dEhyrr5S6XxpJhoBDJvkeq0TCUQZ

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XR7vRF1m+9DS2Pv4r/O4uHwmvtXkChnKbsJCYczn1dvkZbcZSbBm/2UH78dXUaNorOh9XAuCvSjb
ER73y7e0anAfaIf1tJ9Y9pIb8EuNxGS/Pqdvg36cWarwGac9tsscdv/HWfb5Z+qWEk0/uFcLI7pH
CZO7fF2/ONQjA0NtUFBjW4idlx8WrySIuJgDs4jyGkMhbHR3U/ghF1YhMhwgwsbbcptfC1XLrIqQ
OecZnZu8E2hyc5eK/ccYdKcHnXoL55z1p5amI6Fuvz0wKTz2QQ/mwXodfGjEC1ZRWwTn7zCFM91M
qrA1Is49i6pSa7/VICjgn8ULMT1oKGfJLPm7hg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 52736)
`pragma protect data_block
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
F1li3gXbMuWUBqw=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
